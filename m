Return-Path: <linux-edac+bounces-1550-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38869934BB6
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524491C21C8A
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C912C46D;
	Thu, 18 Jul 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yr4I5Tki"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E411B86FB
	for <linux-edac@vger.kernel.org>; Thu, 18 Jul 2024 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298837; cv=none; b=I9bFn2SufGBF6GPAF28nhhDVhgzpIKIhT7j1d5a0jgJR/1yG9s6IT3mc1Ie0ZftzKDJmUKKvdPEZblZKgr2RE0gcpzzAhduawrU8zxFKs4SM7E4C8ehuzeoTlSf7N+zhVmjzPMpZkcIvL21fuOs6S18P79jZ//SZL4AXwTz8Aos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298837; c=relaxed/simple;
	bh=4XgBzjycGWSBBrQwFMCRtpnaaVgDS1KX0nv7LgzbKqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+8bgwu19iluD/kWnyHysdpJfDWCRCTwdCRYY20X5+Q10b9v8L+ny7yXCZ7JDatU58sHjdzVT0WXRd2V2q2rxWgigTYI2wj44h5lYOEEQe1vNuZyGRdbVy6DwTGpFgh9SpC/L4hoZp6IRDWfb3YUHpZpGj5S0FzIb1fds3OkIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yr4I5Tki; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eee1384e85so7882171fa.2
        for <linux-edac@vger.kernel.org>; Thu, 18 Jul 2024 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721298833; x=1721903633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v+h287ifj6s+K3J0t30yGCIPmpGY1Q1ZLm5gQl9XjRo=;
        b=Yr4I5TkinrXX/Hut4mSzNrJvxak9uKjNRmi1CVMb8InWhvDPJ3XL17292sVQ4k089N
         DsdUwxemexwob5+/3BmbeAl1oqWAStOfRIvINWNncy2QOqDbO+KqXbhDCyBL5Ig30kaK
         1pO4HAkgSKl6YiN3t3g7moYApvpIHxN6q2x2BExwqz0SzS5Ieu0nsKOkEbld/m6ETClL
         PCB+EvclNvLKieAV/8NermPQO2hiDIcRM08+57fbYBzXNhVIUy0DEBnEojxR+8WdKI3P
         D8RiuFmX2jhqiZGAr3kIhE/SHydZrmdsRrcdyFx36iblcjNNVkIH8k9BlV2s34nEO+x1
         MPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721298833; x=1721903633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+h287ifj6s+K3J0t30yGCIPmpGY1Q1ZLm5gQl9XjRo=;
        b=XeGPplUqX971+E/i0qCu7w/5OyRpJ1qnXNUy/sXHAo2xHF3c1p6+fSmluO7lg9dfBJ
         06vuNomq61Acl0yaNMLmtoKEpQl8c9zik1D2KPztU2y4SbRDsBAfahmbx+5YRJaGHHja
         7mKHOGH1YxkY3wHNmMyiS5Qvkf2snMORl4HO+4T9Uccxq5Qck1x5R53hQ7rOzPhIhfJX
         E1WUljrHdYvP+ZECsJDdzO+EnopWKt3Cw9PGOp7w4RGzb55Eiw7QgdVdDajLWx3ISVSE
         UkCA8zuOcNEazGOaQk9G8VeUkGODsc57ee1BAlKNl02vrEaRSIHUAnMvkzArQ3gIAmGP
         8xmw==
X-Forwarded-Encrypted: i=1; AJvYcCUDMINbAnKJGDXOwC5kH14uvXaWHQl9f47SlzeyfNqgq/8ouqkk32yZw2BH3Z1F/8MC5MdilFW2/viPXnNDaMPkswGACRv+zn3h/Q==
X-Gm-Message-State: AOJu0Yz+p0Hd9MNguw7uhT++L+j/Tk5odFtN/pjHfHyxX/7IitPGURwu
	j5VUoz8JtNVUz8IPwQSUS2bA3cLyzlfxaOM2sW+6idUc0j7D+BrTKITKbf2pNtKP6ADvMz8kRiq
	sCe8jaCOb+hVl6oT311zy83noTAxs5+FlzwGG2Q==
X-Google-Smtp-Source: AGHT+IHCjC0UyjUkZCeVis2EOTvX9qYFjKU5SpT21H7Ab/b/Ox6naC1A81DsrfWBE21P3cP8fJ0p+oI4yF0oTIumuXw=
X-Received: by 2002:a2e:3c1a:0:b0:2ee:8adb:6190 with SMTP id
 38308e7fff4ca-2ef05d2c4e7mr16006871fa.35.1721298832782; Thu, 18 Jul 2024
 03:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720789921.git.mchehab+huawei@kernel.org> <88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
In-Reply-To: <88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 11:33:41 +0100
Message-ID: <CAFEAcA_4ioaV2Rg8dFFUeAU=tBBq=_TRVpCAUftMeDxu9=gDTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] arm/virt: place power button pin number on a define
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, 
	Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 14:15, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 6 +++---
>  hw/arm/virt.c            | 3 ++-
>  include/hw/arm/virt.h    | 3 +++
>  3 files changed, 8 insertions(+), 4 deletions(-)

Thanks for writing this refactoring patch; I have a couple
of nits below but otherwise it looks good.

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..ad0a0bcec310 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(dev, aml_name_decl("_CRS", crs));
>
>      Aml *aei = aml_resource_template();
> -    /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +    /* Pin for power button */
> +    const uint32_t pin = GPIO_PIN_POWER_BUTTON;

I would say that with the constant name we could now drop that
comment entirely.

>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a345..7b886f3477b6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1013,7 +1013,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> -                                        qdev_get_gpio_in(pl061_dev, 3));
> +                                        qdev_get_gpio_in(pl061_dev,
> +                                                         GPIO_PIN_POWER_BUTTON));
>
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");

You've missed one instance of the hardcoded 3, where we write the
FDT information about it
further down in this function:

    qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
                           "gpios", phandle, 3, 0);

This also can now be GPIO_PIN_POWER_BUTTON.

thanks
-- PMM

