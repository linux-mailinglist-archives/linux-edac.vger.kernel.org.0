Return-Path: <linux-edac+bounces-5463-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE0C6B468
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DBEB4E2511
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8782D7387;
	Tue, 18 Nov 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR3XDYf8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAC15A864
	for <linux-edac@vger.kernel.org>; Tue, 18 Nov 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491589; cv=none; b=TTn2tOZ2Vjxkb/c2cYBBgFqsLBo7ZAfZ784YBG5FBUlRod4W9oTbmoJp6QiujFmmTDbx/74D6PO/07oDyxkE2ZpgbCaVX6GxPC//vcaiIpbo3/M5xE+Cz26xMt/YwEoiEWn0666FGwcHVANCVkcUfBLsvl0gq9xOhpqqftmUt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491589; c=relaxed/simple;
	bh=tf6YfY44HBHAWqekw3lrHBV6futN6BOiQAESrW0W26A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Rqs3adV5C044mHVa8LgCwEAx+CMtN7a6J+ZqJzADFB82nCGyk18TGoAifZyDqx4dLTX8jZpfRRo+4QaisMNOc+nhNffEkGa9rztslTWvHeG0xWy2vKBYbIqsB/X324XqB7/PiiZmhCJnasqteAjanKX/xhgA9CPl8qqvvzaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR3XDYf8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so5605079b3a.1
        for <linux-edac@vger.kernel.org>; Tue, 18 Nov 2025 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491587; x=1764096387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DtntlIEM9d2tsa/owp8mO6HPcXiPOs5cKKk24pA7YE=;
        b=eR3XDYf8wn/D0w3+q9r7coozbiCFrYdbdpc786n0VtX2MmdLKk/cM7DvjvdM8YuFAG
         d3EmRDNfej44leBaGtwwIVyC1NtV+s7sASM05gPEW4v+CHF9VZ5X0krvoGEu35Ly1xI4
         AQOrmpyP4EMQqBy0R1SiPmQC/mEkW75HSym/Gr2TEQB7Gcunavz3CEvGgWy15I3O/k23
         RprEqlhqCycNRn9Ta8LImAo7BynMxlIFXeRxyiHN4+gnsNg/ECaUazHavLIeP+6K5C0t
         OPDdi+iP5MkMtrKrdJImEJy1HwxKtI6sP2mcaEwUpLd05d8zP5MsFKg/hy6aXPA6UFxx
         F2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491587; x=1764096387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DtntlIEM9d2tsa/owp8mO6HPcXiPOs5cKKk24pA7YE=;
        b=TgFf+05r/UmORmalulzhpaqRBgCH4d2Qaf2mVGeZ5nkAzYylkhloysRs7iCaMnpZT9
         RFY6hOmQkx6N1Y3++WOGUtoxkpA8Fvdh4gx7PRvsSruKYaghpje0jPAaGAK0/OLzCdQl
         kqHNWAsxGJvpa17bUtY2Ywb1szXeTJxaEOpHrONABwD18AxC1WrNircrzICGj24j6CEq
         qW7/DaWN4PLacoVPBk2e7cMCOzDjfi+/lvZ9/vxUCwRC49Jvg9RJQ90Wf3vkcYYMqqHl
         JHK0VGhEc1oMRofGMp2FGnGahsjjQHW7of7Uq6FYwUIFmJefoyPaxq+KDM3lGNZK34fs
         1V1A==
X-Forwarded-Encrypted: i=1; AJvYcCWleTCTsvI9sLAma62Vr1kqV4pigWpdNY24RMIX4LFtNZMA7iUwKZbCzEO4YwFHwGxX4fC8CTDOhUly@vger.kernel.org
X-Gm-Message-State: AOJu0YxnnT6bPxnqzM6Mz2x+52NlGuE6qIJmaDwadQMMdofgrTTJ9qg/
	AFvQfGYNDavenUzmUUCoAL+xORIAZYPNPd5F08P/lo2P3n816/nwHYrv/XETDQ==
X-Gm-Gg: ASbGncvP94MbmfekEX000jfVuqgV0HHnLnTmIT8IKOb9MDWeOHozFCukDgB/3iv/i0Z
	u2PYQcC92YUTbDa2pfEm2FHHRK2HOiAwcM4c4znJkzqhDKwDC98eqF/Ehue/ox62aQRoA9fa4BT
	6SK2I38wJ5RRvvy8XqaeOTH6o2zxOq83sjGdRiZqt2pYIcQxm+KGgDRhnFxbfXyVE+4lXy0Aacu
	QU5W6JGwJSp1Pg6v586afDZ9iTyeWGRbLlcAcWhNNDBx9RgigR8UMC15tSQ5fErNE4/RTXHufyQ
	BWZhIqj75+nnjLigym0midi+tP1jYtn1seazH7+esyxN2IuoI3m3SV/Q+yvTEXXX/0kBdzWuaUa
	E8xy6lG6xB3G+nceNgqNZk8EbeSPwT8csvTzmXFaEjs/Oe+2U2H6DvcVLnUqs9jVdQsNmDdCjM6
	ZtIaPheBQBa0E5D/ZVbWbe8Nw=
X-Google-Smtp-Source: AGHT+IF/kZZAv4cXyRWVh2MJivpTvqD/7wZLau7aWc4dg9Ucv7EztbGF7RkoyWkXdvSvTjnQKbQZ/w==
X-Received: by 2002:a05:6a20:9185:b0:334:8759:5016 with SMTP id adf61e73a8af0-35ba17ad845mr22575773637.28.1763491587501;
        Tue, 18 Nov 2025 10:46:27 -0800 (PST)
Received: from ideapad ([139.5.199.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d24b9sm17192294b3a.17.2025.11.18.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:46:27 -0800 (PST)
Date: Wed, 19 Nov 2025 00:16:22 +0530
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"shubhrajyoti.datta@amd.com" <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v3] edac: versalnet: Use kasprintf() to simplify string
 allocation and fix error paths.
Message-ID: <aRy-_vTTBL3jXbOq@ideapad>
References: <SA1PR11MB71307704AC76D92F04FC634489C9A@SA1PR11MB7130.namprd11.prod.outlook.com>
 <20251117110219.35852-2-ayaanmirzabaig85@gmail.com>
 <CY8PR11MB7134D2BE6FD3B07447A8425B89D6A@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134D2BE6FD3B07447A8425B89D6A@CY8PR11MB7134.namprd11.prod.outlook.com>

On Tue, Nov 18, 2025 at 02:02:01PM +0000, Zhuo, Qiuxu wrote:
> > From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> > Sent: Monday, November 17, 2025 7:02 PM
> > To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> > Cc: ayaanmirzabaig85@gmail.com; bp@alien8.de; linux-
> > edac@vger.kernel.org; shubhrajyoti.datta@amd.com
> > Subject: [PATCH v3] edac: versalnet: Use kasprintf() to simplify string
> > allocation and fix error paths.
> > 
> > Replace the kmalloc() + sprintf() pattern with a single call to kasprintf(). This is
> > cleaner, simpler, and avoids potential buffer overflows from the fixed-size 32-
> > byte allocation.
> > Handle possible NULL return from kasprintf() on allocation failure and ensure
> > proper cleanup on error paths.
> > 
> > Also free dev->init_name in the device release function to avoid leak on
> > normal removal.
> > 
> > Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> > 
> > v2:
> >  - Add NULL check for kasprintf() as requested by reviewer.
> > 
> > v3:
> >  - Free dev->init_name in versal_edac_release() to fix the existing leak.
> > ---
> >  drivers/edac/versalnet_edac.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> > index 1ded4c3f0213..360d4f83ed89 100644
> > --- a/drivers/edac/versalnet_edac.c
> > +++ b/drivers/edac/versalnet_edac.c
> > @@ -15,6 +15,7 @@
> >  #include <ras/ras_event.h>
> > 
> >  #include "edac_module.h"
> > +#include "../../include/linux/device.h"
> > 
> >  /* Granularity of reported error in bytes */
> >  #define MC5_ERR_GRAIN			1
> > @@ -755,6 +756,7 @@ static struct rpmsg_driver amd_rpmsg_driver = {
> > 
> >  static void versal_edac_release(struct device *dev)  {
> > +	kfree(dev->init_name);
> >  	kfree(dev);
> >  }
> > 
> > @@ -812,12 +814,19 @@ static int init_versalnet(struct mc_priv *priv, struct
> > platform_device *pdev)
> > 
> >  		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> >  		dev->release = versal_edac_release;
> > -		name = kmalloc(32, GFP_KERNEL);
> > -		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
> > +		name = kasprintf(GFP_KERNEL, "versal-net-ddrmc5-edac-%d",
> > i);
> > +		if (!name) {
> > +			kfree(dev);
> > +			return -ENOMEM;
> 
> On this failure, I think it should "goto err_alloc;" to free the allocated mci instances 
> instead of directly returning -ENOMEM. 

Okay, thanks. I did overlook this, my bad. I apologize for these mistakes I keep
making again and again. I'll make sure there are no more errors in v4.

> 
> > +		}
> > +
> >  		dev->init_name = name;
> >  		rc = device_register(dev);
> > -		if (rc)
> > +		if (rc) {
> > +			kfree(dev->init_name);
> > +			kfree(dev);
> >  			goto err_alloc;
> > +		}
> > 
> >  		mci->pdev = dev;
> > 
> > --
> > 2.51.0
> 

