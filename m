Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253D42F0833
	for <lists+linux-edac@lfdr.de>; Sun, 10 Jan 2021 16:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhAJPtm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Jan 2021 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbhAJPtm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Jan 2021 10:49:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F6C061794
        for <linux-edac@vger.kernel.org>; Sun, 10 Jan 2021 07:49:01 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c13so6773872pfi.12
        for <linux-edac@vger.kernel.org>; Sun, 10 Jan 2021 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+4PfVpWzIwPp8aKWtKGCptiTFkBNjW8LRR/4faGpkhk=;
        b=uetcUeWGL+KLQeDlN6q0dqdxyDb8W98E1HoxCyviCDAokQX0QprFgLLHwPSaSERuCI
         b+sW1fiNX1jGsa5AXWGoa9eRiz6MzMe14FJiz/H3my+AJpNhkv7+14v4r7G00he6aY3j
         KuJlVLxHLdwULhGm6DKMt2h/rtSHhOTcMxYUSLDV3MkLsvTUU5SGYoInjUj+kAx/0fbR
         u9QyzKaW3OyMQVkdzRlFQTBj93G9p42lFCnOPb85CgYRtOOOw0w/XfsV2yP2SCvwrlfA
         yMKjHdqu/mTDaOSF8omgy/IjJAGyfGHMWYy0XtR6arlQ55Hotn3zpp0NdiAO4XAXrpwe
         gEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+4PfVpWzIwPp8aKWtKGCptiTFkBNjW8LRR/4faGpkhk=;
        b=ngrphSC1St/fyywHr1tu86BePQLwGfMqlqH+ZEUOrv60G5zXfjqJ1PFkk5m3RdXVk8
         QWpHpsuZU/NlArDUn2IXD6bgPCYXEpzm9tj3VG5D4TMz5A/iOcNn2Wq0baH6b2wWBPZs
         j7vnElqLOWFYqGMf2AvJEEn3plrPRgO9lGrI/9MjdaLmNDKDk2alfnlZl2rFRsJIoWjq
         p9dQZU61hWyEkpyaX1UqJ4JdeBGFCcIAR7OWm9BFKx6v5Y/1jGsyDwyIOCkiuUhg37xZ
         Cicbk/jdr+u2xqzukt7i/fZesNtpuZVe/D1PpP5ezc0cJ/TPxC+e7C7wfwP0uu4mITyC
         0hMQ==
X-Gm-Message-State: AOAM533kb8a1Dnt1Oe0/vqZh8rtcXSyZDSCuXODHGa9MtO6kQ5NmZCNO
        Q5Ze2DMe+FeIj7knRbViWIYp
X-Google-Smtp-Source: ABdhPJyYfhLMVP2TMnuARZ+px/60XGDJc7t5XLSGFCjLDWxXyCz/sXm3e2Q9C8ix2ohXgPGNtIulsg==
X-Received: by 2002:a63:1315:: with SMTP id i21mr16045078pgl.370.1610293741244;
        Sun, 10 Jan 2021 07:49:01 -0800 (PST)
Received: from thinkpad ([2409:4072:6d1d:b3a0:54f0:7e43:912d:37b2])
        by smtp.gmail.com with ESMTPSA id 123sm17076145pgf.38.2021.01.10.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 07:49:00 -0800 (PST)
Date:   Sun, 10 Jan 2021 21:18:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, baicar@os.amperecomputing.com,
        saiprakash.ranjan@codeaurora.org, bjorn.andersson@linaro.org
Subject: Re: EDAC driver for ARMv8 RAS extension is being worked on
Message-ID: <20210110154853.GB15624@thinkpad>
References: <20210110151149.GA15624@thinkpad>
 <20210110152943.GD22211@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110152943.GD22211@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jan 10, 2021 at 04:29:43PM +0100, Borislav Petkov wrote:
> On Sun, Jan 10, 2021 at 08:41:49PM +0530, Manivannan Sadhasivam wrote:
> > I've collected the feedback on those submissions and came up with the idea of
> > a single "armv8_ras_edac" driver which will work for both Devicetree and ACPI
> 
> "ras" and "edac" both is too much. Just call it armv8_edac or arm64_edac or so.
> 

Okay, sure.

Thanks,
Mani

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
