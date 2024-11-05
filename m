Return-Path: <linux-edac+bounces-2443-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C079BD231
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE34B22B33
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C255185B69;
	Tue,  5 Nov 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRxp8rPA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD117C7CE;
	Tue,  5 Nov 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823637; cv=none; b=EezEDqHFFCf2aiNkhEZ4i5MtvDEL524Z8aZJ8T626eCV5IxlOOl2cWVy/5kZ6eeorDGjo0I/8btZoW8YU7Rjdg6hY/FJ/eT+PUy7dgBc3DvvowMqBg5Bg3dXS2ccOYx/uSwP1VdpIcxPKC2GBM2x+OPY7ZWdf/Dl1wGw6yiylIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823637; c=relaxed/simple;
	bh=nDvXCNsb8eYM06SGkhcLetDsEF3n1/904tu5W0cNaGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAu7HdWQONL7s7nKZ3gKaIInsO37kAahD4H49MBrzlSiMaOxYd2ntvHIw1qBDIBRuCPt7YD67taodK5I7cI2RdicwvafL0pjB7WgNJUV+f6qpcPwuteDqCHwLkggo9WG7/gWy5BIyJZyIqBPcCFuBTo9j0tKM8YsjngbLEg1KuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRxp8rPA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7203c431f93so4830179b3a.1;
        Tue, 05 Nov 2024 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730823634; x=1731428434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6T2iq8xGI+GqUXUHOGirwT3Xvq/NBM9rIaYvFjPiks=;
        b=lRxp8rPAHP7UQcETaIZyl3iZNShvay8Wj86RGFXvmY2gdvSLrzsv1ex6ljAUn8Kl79
         /K/oX9dDCN4s0tAsf0Cb+YcgZSbLzPThNAD1dS9/mA1N6SBVdrfbR+axcs5BNS7PKIZ5
         ShXdF7L5+xuFfBVYXBm4MiIaq6LIJNw3Pqcs+Q0mrwg8wMpG0IWEtXdmrLux1aQJKwDc
         2oJFs8NQZtKpcavya/Q5L42QH79M6clMA5TG1lpD/gG1iXA3Tp185HRmNPJXWvQj/PaM
         rNf63KC4986F9JulKf47/qArTJ6uFtG6QrRuyFRv/KJvdkN7v5pkrcIQyjgzpJonXYVr
         6EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730823634; x=1731428434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6T2iq8xGI+GqUXUHOGirwT3Xvq/NBM9rIaYvFjPiks=;
        b=bQUkAnJGqnscjMV9k1lRsccZxpUWEg5jHGQGUCxWB2nzk/1D+GUZpC6sRviIzzM7AA
         BKd+Fl9L7QSj00A69lb0rQOq7eK3X7Lgo0u3WGD0N3LUq9l3Ncz61ZqjrVQ/QGwuWghL
         ncko/WkEsby54hPU+VoQDfux1cLX7CuSNLJMxkHPEJmrjk8UuGxESX76oQC/ouoyKPjF
         3V7mayRyvN7g/QTi58g/5foj9ykcMq0DOlx7Rp6Txr5821ggM4I/RGmL84JJZ0+mYPWE
         9GE6nns3VWHbs4krhMbo1c9SwAJAR8UsPayo06cjZFLo7RgisAHDa6qJvTEdqmEEBfCs
         +4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjTZwe14ZoiGLj8Egi6FoAhYTA0Qux34qFzSCtBb88sD0mKciOTjMC3xDwdnTqBz1rxCm/fqLcycc@vger.kernel.org, AJvYcCW+Nbc1ZqJrtKHCU+oup2AyemV/ANYN6z3+9OVKataBkfJvlvkJkmujYn1fEr+CP0B2KBu72o1cBtpLTuXA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0P0Z9XPw3fgrouV6fArqbMi/aqjeslywg6NMOcyexuHv3g1yS
	JKUrwp4yTpz1UL8kyziIl5GfcujxVCAlrWRNgIgQt6RP3tCDkSMC
X-Google-Smtp-Source: AGHT+IH3eFdH8xQR7RwLs5YMlO2d6Mt3046DnfDK6BPgHc1hqjXptxdQ5+TEBz4IT/kVloc8MQqNhA==
X-Received: by 2002:a05:6a20:158a:b0:1db:e82f:2a63 with SMTP id adf61e73a8af0-1dbe82f2b1emr5947334637.3.1730823633768;
        Tue, 05 Nov 2024 08:20:33 -0800 (PST)
Received: from Emma ([2401:4900:1c97:5a7:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3e08sm9799048b3a.105.2024.11.05.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:20:33 -0800 (PST)
Date: Tue, 5 Nov 2024 16:20:27 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <rk37tcrlpnziymqpj72f2glu4kh7v5pgxnurhnmuwhwkyuyfpm@iqvzvuicy3xu>
References: <20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com>
 <3c347f99-485c-453d-9b9a-9924abf1e868@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c347f99-485c-453d-9b9a-9924abf1e868@linuxfoundation.org>

On Mon, Nov 04, 2024 at 02:51:56PM -0700, Shuah Khan wrote:
> On 11/4/24 11:34, Karan Sanghavi wrote:
> > Explicit cast pc to u32 to avoid sign extension while left shift
> > 
> > Issue reported by coverity with CID: 1593397
> > 
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---
> > Coverity  Link:
> > https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397
> 
> Please include the coverity message instead of this link so
> reviewers without coverity accounts can see the report.
>
sure will keep it in mind. 
> > ---
> >   drivers/ras/amd/atl/umc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> > index dc8aa12f63c8..916c867faaf8 100644
> > --- a/drivers/ras/amd/atl/umc.c
> > +++ b/drivers/ras/amd/atl/umc.c
> > @@ -293,7 +293,7 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
> >   	}
> >   	/* PC bit */
> > -	addr |= pc << bit_shifts.pc;
> > +	addr |= (u32)pc << bit_shifts.pc;
> 
> How did you determine this is the right fix and how did
> test this change?
>
#define ADDR_SEL_2_CHAN GENMASK(15, 12)

bit_shifts.pc = 5 + FIELD_GET(ADDR_SEL_2_CHAN, temp);

After reviewing the code, I found that bit_shifts.pc can reach a maximum value of 20. 
Left-shifting a u16 pc by this amount results in an implicit promotion to an int64_t, 
which can cause sign extension and lead to unintended negative values.

To avoid this, casting to a larger data type (such as u64) woulbe be most 
appropriate solution here. 

Also,using u64 would be more appropriate rather than u32. 

Should I send a new patch with u64?  

> >   	/* SID bits */
> >   	for (i = 0; i < NUM_SID_BITS; i++) {
> > 
> > ---
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > change-id: 20241104-coverity1593397signextension-78c9b2c21d51
> > 
> > Best regards,
> 
> thanks,
> -- Shuah

Thank you,
Karan.

