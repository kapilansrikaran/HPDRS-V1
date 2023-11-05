package com.ruhuna.backendv2.web;

import com.ruhuna.backendv2.model.Property;
import com.ruhuna.backendv2.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class PropertyController {

    @Autowired
    private PropertyService propertyService;

    //display list of property
    @GetMapping("/")
    public String viewHomePage(Model model) {
        return findPaginated(1, "propertyName", "asc", model);
    }

    @GetMapping("/showNewPropertyForm")
    public String showNewPropertyForm(Model model) {
        // create model attribute to bind form data
        Property property = new Property();
        model.addAttribute("property", property);
        return "new_property";
    }

    @PostMapping("/saveProperty")
    public String saveProperty(@ModelAttribute("property") Property property) {
        // save property to database
        propertyService.saveProperty(property);
        return "redirect:/";
    }

    @GetMapping("/showFormForUpdate/{id}")
    public String showFormForUpdate(@PathVariable( value = "id") long id, Model model) {

        // get property from the service
        Property property = propertyService.getPropertyById(id);

        // set property as a model attribute to pre-populate the form
        model.addAttribute("property", property);
        return "update_property";
    }

    @GetMapping("/deleteProperty/{id}")
    public String deleteProperty(@PathVariable (value = "id") long id) {

        // call delete property method
        this.propertyService.deletePropertyById(id);
        return "redirect:/";
    }


    @GetMapping("/page/{pageNo}")
    public String findPaginated(@PathVariable (value = "pageNo") int pageNo,
                                @RequestParam("sortField") String sortField,
                                @RequestParam("sortDir") String sortDir,
                                Model model) {
        int pageSize = 5;

        Page<Property> page = propertyService.findPaginated(pageNo, pageSize, sortField, sortDir);
        List<Property> listProperty = page.getContent();

        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());

        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");

        model.addAttribute("listProperty", listProperty);
        return "index";
    }
}
