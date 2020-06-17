Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6DF1FD04D
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFQPHl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQPHk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Jun 2020 11:07:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F25C06174E;
        Wed, 17 Jun 2020 08:07:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h10so1402549pgq.10;
        Wed, 17 Jun 2020 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ITzc3JaPDxAKOQYTX8/bmia/YNb0R8QCocUSGMg4MW4=;
        b=VG51dWDTTWJ1BPPW1x9m5auHEl5lcctVlIPQsjXbZ75e1gNtgey2/ZD45gcGBNt916
         ws0vWK4I64S1xgVA6oVdIvk2H5XqtTpkqPqujNLecnm7mczvz1ArFATx+GDbq3ZY+/5V
         Z7jG9jxAT+tTlvqHYzATpTbTuNZ2f6imtacT2t2JYwmHUHKm5ScwWxcL0LhnIBKcGPK/
         CKPAlqZDhwvJ3z4HrJRbhfUkLv7eNzjgFj4gTU0FecsQXB6+Cwlla2TjsUVZsoT2weQZ
         lHp0XaIO5h3j2JatvLCX25R0L0UOeV4EpsBXrqqvTd342LWsr3V2EqZBQCb9Ecd4OAtl
         0jOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ITzc3JaPDxAKOQYTX8/bmia/YNb0R8QCocUSGMg4MW4=;
        b=HwQJ14jxNKq21nUC1+krYkjnsXpdklJ7ZwOc96P16hF6T8mnaPwyNFAm8Zy7pC/dVP
         WihbccUdyJxIsEwKE2jma8qLmI2E7Y3psStENg23M3KJEzISE3dy/GIOs1LDsqX0XVLf
         K1zbZQRRofa+ZvHpK/k2Z088lsqaHu7iS5o4Vil0fpqbca/EEatXf/RPqUSW979c2mx0
         1Gv9eQxKrMuEE6NjxUgELKgUpTIPpJ9e8hBMPIrLyRyvZu88mfFVFApE1nfGcEQIDvqj
         f4qlB5/Sf8g0Q18toA0tXO5YXFA+p5Pn24r4ONLTmm5CT//mz9bHVO1B7TKPU67p+rJo
         48Bw==
X-Gm-Message-State: AOAM531jlx1qSPqVCYEPRm4Nj2Isg42SjJoDJv7AlWgqATe2vvl+1hqU
        KjrgZA1qMKdlK1jtZqrYhA==
X-Google-Smtp-Source: ABdhPJzO6j5bZRD8LqIHF8Z2IMbxZA9qtExXNUxiLO5wdupsF2FLJsKpQeAda5aI+I/XkaqLWQAPIg==
X-Received: by 2002:a63:5d19:: with SMTP id r25mr6666766pgb.360.1592406458466;
        Wed, 17 Jun 2020 08:07:38 -0700 (PDT)
Received: from localhost (98.86.92.34.bc.googleusercontent.com. [34.92.86.98])
        by smtp.gmail.com with ESMTPSA id y4sm177251pfr.182.2020.06.17.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:07:37 -0700 (PDT)
Date:   Wed, 17 Jun 2020 23:07:35 +0800
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, yazen.ghannam@amd.com,
        bp@alien8.de, clemens@ladisch.de
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
Message-ID: <20200617150735.GA405893@i716>
References: <20200616180940.GN13515@zn.tnic>
 <20200617013255.391975-1-hengqing.hu@gmail.com>
 <20200617034028.GA1614@roeck-us.net>
 <20200617071927.GA398128@i716>
 <alpine.LNX.2.20.13.2006171739010.31660@monopod.intra.ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.20.13.2006171739010.31660@monopod.intra.ispras.ru>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

Sorry, I apologize for didn't do much lookup that you already did the patch
submission before I submitted the patch.
I have to say we are all programmed by the programs.
Also I didn't submit to either of the lists.
A few places I did looked at are below before I did the submission.
https://pci-ids.ucw.cz/v2.2/pci.ids
https://lore.kernel.org/patchwork/project/lkml/list/

Jacky
On Wed, Jun 17, 2020 at 05:54:36PM +0300, Alexander Monakov wrote:
> Hi,
> 
> I've already said in my patch submission (which was Cc'ed to LKML,
> linux-edac and linux-hwmon so you should have been able to find it):
> 
> >> It appears SMU offsets for reading current/voltage and CCD temperature
> >> have changed for this generation (reads from currently used offsets
> >> yield zeros), so those features cannot be enabled so trivially.
> 
> In https://github.com/FlyGoat/ryzen_nb_smu/issues/3 there some
> reverse-engineered info that indicates that for Renoir, SMU region has been
> moved to 0x6F000. Its layout also changed, as far as I can tell.
> 
> (also, please ask yourself if you want to offer the maintainers an apology)
> 
> Alexander
