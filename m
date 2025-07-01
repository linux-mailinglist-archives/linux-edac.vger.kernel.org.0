Return-Path: <linux-edac+bounces-4294-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E0AEEB13
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 02:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647773BA588
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 00:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7479E1;
	Tue,  1 Jul 2025 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLIrB1zI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3F2F41;
	Tue,  1 Jul 2025 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328194; cv=none; b=UCyMG0gFE1uGJDboK9L4hcIya/t6/5agIarI10DenSGdxUu12pWsF8KymnFVYs9/cpB0vs10fme8fy/ZpFQdf8e/vZHBtv3ZbyGWOeinLutCY28fo1k72HWJZMTo8IBDLLaHywA5oe5wV3KreiFo9ELZActMvK5NE5IldmDZCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328194; c=relaxed/simple;
	bh=r3HO+OmwgBy9rHu1SO2ar2a5RsyDb8ikV2VwcVG1RBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4vWus/z9BYZntiVHAhIQFfjXRAkLJUHGlOgx/m//OQ/7rlY6w96veKtOzolL58v+KxVaLEMGzc9JrwJPjAWhthGiSGp+DZhO+1GjURwJXM5gPtSPEFtwCegddi+X52iVatT0oLY2C5CTs0dDb0ty1XazR+BWLNVogQL4pB4LJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLIrB1zI; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6113e68da82so2029611eaf.1;
        Mon, 30 Jun 2025 17:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751328192; x=1751932992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ENsEpAeVLDs9lQsTFPW2zvKgMcTyFgJZvhlvMb6Kpk=;
        b=XLIrB1zI27blgevLYlx3Uk1PekkyBEpWjGW6I8hB2Orn4ROX/PE+kn3eyIlwXJ832T
         pattBJBsBORwyqhY/6rIhMqbxbB72uIJ0p0+klg3khrQDY77IJzIf2AkHRik/37UBpiQ
         lzs6XJAU2QojbHxM6CzKp0dcvmvQEyO2W8KaW37Q8IwlHg1ieFo6Oioe9JB93L1XlpVZ
         KHDOYmvf9W52RUTbKGWAsCrGq9t/EHbmD8ovLyVRmPsHnVwpWhB1wOrMU1+H8ojj9v1S
         gVKUJOK1XvlAC7p6U/2k3kk8aVICi+TjOdRvMZ/CuXjp5GfJLlPCsJweM0NKjpmXLPQc
         6RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751328192; x=1751932992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ENsEpAeVLDs9lQsTFPW2zvKgMcTyFgJZvhlvMb6Kpk=;
        b=Tb4YWLgcimrGSF4nNyC0qO/0tNiUAQH/QVYodcmR6UmdK4MwcrexMKSOZlfPF0nf72
         kbaqtAQz4ZuI9d4L6ph3cWnrFHjBYbxiim74uV8+MnSCzCYsuyB+6Rz2otJejNDvCaj6
         tXSOvf/7loGNVL3kyxyLBdGCIml4taWJZjaLH6W/b+R5tDwA26OFUQMsAREaPSv7LKQB
         r3g+8Xv1rJxk++uzYh13CnzjFYw1apGIi8ejWVQzEq/XswmdgRt+iuhFTwTYUkBJCnnf
         J/OZZVVzXs8cx6ge1P4SsijIqBQOWL0nWTDv0f8DDze54wdlcG5UAu96vaQe1M8X8m5n
         3pMg==
X-Forwarded-Encrypted: i=1; AJvYcCUBnKwFiFTOQz1Wuorb2Ngx/+lp3L9QGZ+EZn0+gsJ/xikIKhPSCWRgFyo+IPYC1LGvdLL0HZbBgRvIxntI@vger.kernel.org, AJvYcCX61yD2W0MHnD7UDAGX44MhDQbDWtfVlg9Z0XO/kzi9Gmwju17LPtaK4nEnZ2NmM7wHnJcBSFjxKsi4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kJehHV6u06ReB4aQLGEOTzAUxbqT9ZAQWQU2PKxidqeYdt1d
	NUPqeLFrx45moSDbVshbRKgmWCeCidmn51TgsAtgD4kHooGbuunnlGguH/2rhNs/KeY/AQeQVJj
	LwLPSezQV5Nlkw3cPdyBLAt9lTaBpTLE=
X-Gm-Gg: ASbGnctOMeTBsyqs3dEfN4v/m6DsO1V1QbLED44Txcy8yk/0vOYK+gDcmI+NY1wa3Ts
	U9nS/FUzMqEyqbmV+wFHKJGgtbP8X3jNwAmnz+B1d/X80REoGB9rW6AXQQTT7wSbqOPWh884rqI
	loVGMFJMKEmOAdar/d8ULzNprBsmPe8gTX9rSCJyu+f6g=
X-Google-Smtp-Source: AGHT+IHG3LB3qgHlRcmTBxxBoMm0+Rmi1QgY4I9XqPAvIJm4k3s7YqMw8buhpfA4dYy9s20bpx4JN0bsyTV65Ag6KLw=
X-Received: by 2002:a05:6808:1206:b0:406:1e0c:3196 with SMTP id
 5614622812f47-40b33e5ea83mr12052103b6e.28.1751328191746; Mon, 30 Jun 2025
 17:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629182448.265407-1-marcelomoreira1905@gmail.com> <2025063001-marigold-renewed-6361@gregkh>
In-Reply-To: <2025063001-marigold-renewed-6361@gregkh>
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
Date: Mon, 30 Jun 2025 21:03:00 -0300
X-Gm-Features: Ac12FXysXiINyh4vhy75pryO5gVlJChGshOynnHRZOmiISFWcogSj31YiL2CQ-k
Message-ID: <CAPZ3m_jo+28S-ouR0DBL9gXEmrM7RjY74MSHx=DE9G4KpRZ4Pg@mail.gmail.com>
Subject: Re: [PATCH] EDAC/amd64: replace sprintf with sysfs_emit in show functions
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, ~lkcamp/patches@lists.sr.ht, 
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, 
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 30 de jun. de 2025 =C3=A0s 02:07, Greg KH
<gregkh@linuxfoundation.org> escreveu:
>
> On Sun, Jun 29, 2025 at 03:24:48PM -0300, Marcelo Moreira wrote:
> > Update all device attribute 'show' callbacks in the EDAC AMD64 driver t=
o
> > utilize sysfs_emit(). This change adheres to the recommendation outline=
d
> > in Documentation/filesystems/sysfs.rst.
> >
> > This modification aligns with current sysfs subsystem guidelines.
> >
> > Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
> > ---
> >  drivers/edac/amd64_edac.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index b681c0663203..b6d211255ef0 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -552,7 +552,7 @@ static ssize_t reg##_show(struct device *dev,      =
                       \
> >       struct mem_ctl_info *mci =3D to_mci(dev);                        =
 \
> >       struct amd64_pvt *pvt =3D mci->pvt_info;                         =
 \
> >                                                                       \
> > -     return sprintf(data, "0x%016llx\n", (u64)pvt->reg);             \
> > +     return  sysfs_emit(data, "0x%016llx\n", (u64)pvt->reg);         \
>
> Why the extra ' '?

I didn't notice, sorry.



>
> >  }
> >
> >  EDAC_DCT_ATTR_SHOW(dhar);
> > @@ -571,7 +571,7 @@ static ssize_t dram_hole_show(struct device *dev, s=
truct device_attribute *mattr
> >
> >       get_dram_hole_info(mci, &hole_base, &hole_offset, &hole_size);
> >
> > -     return sprintf(data, "%llx %llx %llx\n", hole_base, hole_offset,
> > +     return sysfs_emit(data, "%llx %llx %llx\n", hole_base, hole_offse=
t,
> >                                                hole_size);
> >  }
> >
> > @@ -602,7 +602,7 @@ static ssize_t inject_section_show(struct device *d=
ev,
> >  {
> >       struct mem_ctl_info *mci =3D to_mci(dev);
> >       struct amd64_pvt *pvt =3D mci->pvt_info;
> > -     return sprintf(buf, "0x%x\n", pvt->injection.section);
> > +     return sysfs_emit(buf, "0x%x\n", pvt->injection.section);
> >  }
> >
> >  /*
> > @@ -638,7 +638,7 @@ static ssize_t inject_word_show(struct device *dev,
> >  {
> >       struct mem_ctl_info *mci =3D to_mci(dev);
> >       struct amd64_pvt *pvt =3D mci->pvt_info;
> > -     return sprintf(buf, "0x%x\n", pvt->injection.word);
> > +     return sysfs_emit(buf, "0x%x\n", pvt->injection.word);
> >  }
> >
> >  /*
> > @@ -675,7 +675,7 @@ static ssize_t inject_ecc_vector_show(struct device=
 *dev,
> >  {
> >       struct mem_ctl_info *mci =3D to_mci(dev);
> >       struct amd64_pvt *pvt =3D mci->pvt_info;
> > -     return sprintf(buf, "0x%x\n", pvt->injection.bit_map);
> > +     return sysfs_emit(buf, "0x%x\n", pvt->injection.bit_map);
>
> There's nothing wrong with these sprintf() lines, so no need to change
> them, right?
>
> I only recommend making this type of change when adding new sysfs files,
> no need for churn on old files when it is not needed at all.
>

Understood Greg, thanks for the feedback :)

--
Cheers,
Marcelo Moreira

