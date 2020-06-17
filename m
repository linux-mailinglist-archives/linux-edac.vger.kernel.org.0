Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADCF1FC71D
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgFQHTb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 03:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHTb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Jun 2020 03:19:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C38C061573;
        Wed, 17 Jun 2020 00:19:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so565189pjb.1;
        Wed, 17 Jun 2020 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZZQRc8cSih9KfpaA3PdbcUNW5+QnVP16MnOdITJs0uY=;
        b=VtyYKKn+sOaDU5VHlilWhWIIv2BrJkFOKuEqsvLnfoNTBZ5mHTRltx4dfm1p1stZ7E
         WoZkW6kUztSKZc8w+bFhkVEHxALpSn7ZNj8wZckvhsBDuZeCD/1ukiFIU/jRIEarAt3G
         pDuEOdYRA5A6hy49OjN8g7ddOOtE+htt6OhqHSJFtMldh+taw2Bs4JYrD+dxLPUCVu60
         zyYw1+f6MHtx9KU4OUYr/uJaIeYCpWxd7QSLwTxuMNSbKWkDjTV2YdBpX7oI4/Pz+90T
         8Wh4IMAzHY690hi6WmzLhbhNlh0wTGmJGJK+vzR9rvbHBpH+TA6hgwCIQpEvebi7U1Bp
         3yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZZQRc8cSih9KfpaA3PdbcUNW5+QnVP16MnOdITJs0uY=;
        b=sRFcMBSf81QhmDRANeCUL8euTc8FXhmpzS21fpLfqtuNM+H9xnFiNHwgWqprTF68LD
         Z4Uc7rTsDqKhAuG55sg58Vcwrkm7KzyWYY0p5CuTGXHPIxRxPEqiw5/uERMKR6jgZp8J
         VPut8UVS3I7OyvaLNuIHXCePdQ9crH9u3RERJU8i7W2OyOLr9p//Xjkjzod1mxMDnKBr
         5jhpKEAEJtBqSXaIufQGXhF6xxU9WSOp6FWmt+CG9j8FjtLAr12q+0f0qL0zvStQExTZ
         2olng5L8AoGNj57MmjBJxPJgB755w9u5q3r1HfC71fZguj+3QB+c6LgypoSi4bx/yOeb
         OFxg==
X-Gm-Message-State: AOAM533ploVOZlU2mJd0X8U65vzVDEom7AWH2TMQXhOTgjU4NLWXQmyI
        8vFerzgAbmMtrS3yLwnM2w==
X-Google-Smtp-Source: ABdhPJyIeenl7cQD2kDC60mWB6VjXLS+6tkAg3ZmwdCKFO3OWqhGMdrjdWeB9LO/ibHX9g/YYbfEsA==
X-Received: by 2002:a17:90a:6047:: with SMTP id h7mr6370455pjm.145.1592378370875;
        Wed, 17 Jun 2020 00:19:30 -0700 (PDT)
Received: from localhost (98.86.92.34.bc.googleusercontent.com. [34.92.86.98])
        by smtp.gmail.com with ESMTPSA id c7sm16548917pgh.84.2020.06.17.00.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 00:19:30 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:19:27 +0800
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        yazen.ghannam@amd.com, bp@alien8.de, clemens@ladisch.de
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
Message-ID: <20200617071927.GA398128@i716>
References: <20200616180940.GN13515@zn.tnic>
 <20200617013255.391975-1-hengqing.hu@gmail.com>
 <20200617034028.GA1614@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617034028.GA1614@roeck-us.net>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Guenter,

By increasing the regs count from 32 to 256 and looking into the output of `cat /sys/kernel/debug/k10temp-0000\:00\:18.3/svi`
There is some data from 0x05a300 - 0x05a330
Do you have any idea how we can guess the offset for this model?

0x05a000: 00000000 00000000 00000000 00000000
0x05a010: 00000000 00000000 00000000 00000000
0x05a020: 00000000 00000000 00000000 00000000
0x05a030: 00000000 00000000 00000000 00000000
0x05a040: 00000000 00000000 00000000 00000000
0x05a050: 00000000 00000000 00000000 00000000
0x05a060: 00000000 00000000 00000000 00000000
0x05a070: 00000000 00000000 00000000 00000000
0x05a080: 00000000 00000000 00000000 00000000
0x05a090: 00000000 00000000 00000000 00000000
0x05a0a0: 00000000 00000000 00000000 00000000
0x05a0b0: 00000000 00000000 00000000 00000000
0x05a0c0: 00000000 00000000 00000000 00000000
0x05a0d0: 00000000 00000000 00000000 00000000
0x05a0e0: 00000000 00000000 00000000 00000000
0x05a0f0: 00000000 00000000 00000000 00000000
0x05a100: 00000000 00000000 00000000 00000000
0x05a110: 00000000 00000000 00000000 00000000
0x05a120: 00000000 00000000 00000000 00000000
0x05a130: 00000000 00000000 00000000 00000000
0x05a140: 00000000 00000000 00000000 00000000
0x05a150: 00000000 00000000 00000000 00000000
0x05a160: 00000000 00000000 00000000 00000000
0x05a170: 00000000 00000000 00000000 00000000
0x05a180: 00000000 00000000 00000000 00000000
0x05a190: 00000000 00000000 00000000 00000000
0x05a1a0: 00000000 00000000 00000000 00000000
0x05a1b0: 00000000 00000000 00000000 00000000
0x05a1c0: 00000000 00000000 00000000 00000000
0x05a1d0: 00000000 00000000 00000000 00000000
0x05a1e0: 00000000 00000000 00000000 00000000
0x05a1f0: 00000000 00000000 00000000 00000000
0x05a200: 00000000 00000000 00000000 00000000
0x05a210: 00000000 00000000 00000000 00000000
0x05a220: 00000000 00000000 00000000 00000000
0x05a230: 00000000 00000000 00000000 00000000
0x05a240: 00000000 00000000 00000000 00000000
0x05a250: 00000000 00000000 00000000 00000000
0x05a260: 00000000 00000000 00000000 00000000
0x05a270: 00000000 00000000 00000000 00000000
0x05a280: 00000000 00000000 00000000 00000000
0x05a290: 00000000 00000000 00000000 00000000
0x05a2a0: 00000000 00000000 00000000 00000000
0x05a2b0: 00000000 00000000 00000000 00000000
0x05a2c0: 00000000 00000000 00000000 00000000
0x05a2d0: 00000000 00000000 00000000 00000000
0x05a2e0: 00000000 00000000 00000000 00000000
0x05a2f0: 00000000 00000000 00000000 00000000
0x05a300: 00000000 00000001 00000000 00002710
0x05a310: 00000000 00000008 0000000e 00000000
0x05a320: 00000001 0000c000 00000000 0000000b
0x05a330: 00000001 00000000 00000000 00000000
0x05a340: 00000000 00000000 00000000 00000000
0x05a350: 00000000 00000000 00000000 00000000
0x05a360: 00000000 00000000 00000000 00000000
0x05a370: 00000000 00000000 00000000 00000000
0x05a380: 00000000 00000000 00000000 00000000
0x05a390: 00000000 00000000 00000000 00000000
0x05a3a0: 00000000 00000000 00000000 00000000
0x05a3b0: 00000000 00000000 00000000 00000000
0x05a3c0: 00000000 00000000 00000000 00000000
0x05a3d0: 00000000 00000000 00000000 00000000
0x05a3e0: 00000000 00000000 00000000 00000000
0x05a3f0: 00000000 00000000 00000000 00000000 

Thanks.
Jacky
On Tue, Jun 16, 2020 at 08:40:28PM -0700, Guenter Roeck wrote:
> On Wed, Jun 17, 2020 at 09:32:55AM +0800, Jacky Hu wrote:
> > With this patch applied, output from 4800H (idle) looks as follows:
> > 
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > Vcore:         1.55 V
> > Vsoc:          1.55 V
> > Tctl:         +49.6°C
> > Tdie:         +49.6°C
> > Icore:         0.00 A
> > Isoc:          0.00 A
> > 
> > Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
> > ---
> >  drivers/hwmon/k10temp.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> > index 8f12995ec133..287e9cf2aab9 100644
> > --- a/drivers/hwmon/k10temp.c
> > +++ b/drivers/hwmon/k10temp.c
> > @@ -583,6 +583,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  			k10temp_get_ccd_support(pdev, data, 4);
> >  			break;
> >  		case 0x31:	/* Zen2 Threadripper */
> > +		case 0x60:	/* Zen2 APU */
> 
> Unfortunately it is not that simple. Output above and the little data I have
> available suggests that current and voltage measurements are different on the
> APU. That means that show_current must remain false.
> This will require a separate case statement which doesn't set any flags.
> 
> Guenter
> 
> >  		case 0x71:	/* Zen2 */
> >  			data->show_current = !is_threadripper() && !is_epyc();
> >  			data->cfactor[0] = CFACTOR_ICORE;
> > -- 
> > 2.27.0
> > 
