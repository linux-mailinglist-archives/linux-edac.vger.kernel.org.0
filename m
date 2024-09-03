Return-Path: <linux-edac+bounces-1768-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1950896919E
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 05:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519311C229A7
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 03:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5819F137;
	Tue,  3 Sep 2024 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9I41z+Q"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369101A4E6A;
	Tue,  3 Sep 2024 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725332551; cv=none; b=Z2izswpWSKgGcRbBqKC/N9Pulh/zxVwoBWMoPJzecrJ5/JP+P9harNbt8cSLoxBZT72OfC5hV17TmUS4ic9QDuRN2b6ldVjPaN2z1eZJiyMJeVcVGUsN+4Fjva1obogEkC6GFDrmfRjLSzqfGQHGBHS/3zkrMLRlq95iNH7rAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725332551; c=relaxed/simple;
	bh=h+g1/mX4LLwAzCcVh57Se91YX7evCRnFhLAJ8vk4noI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiWA+UDC6PVCHDxYQbBsW0ORsJhZ67OunBOPRT3uKfOSoCMKvSiWN7kO/uCXdJEmw4/4+D6rAz/ZwHFvws1ky3tLoyUsTCwR3xlV5F7fIdfdWn4x9isriYq318/HnyhjIXyVmB+wcfO71Szg/UxROJWvkjLCBMj/XpjIrwyYC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9I41z+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CE3C4AF09;
	Tue,  3 Sep 2024 03:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725332550;
	bh=h+g1/mX4LLwAzCcVh57Se91YX7evCRnFhLAJ8vk4noI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a9I41z+QcoLSsEZgzH9/B8NMy+zBugNN9JdsTX/aTq3ImVAXqe2IyYW5mOrEDSUiz
	 HgzvlgzGtwfj8UQc+9qwPZn6n1qtDePUgZGQMw69Q7WTxay4MoO6EiMD4KTP2rha1L
	 GD4vX1NsmxylPEn6gBQsmbKCGtH4FYPSg2gqW4+kkd8Wb9YgZiVarS8kacX4DW3B4X
	 KqdlcAUobtCTrYisPNoYjtAczKJtDx5bB8q1+Q8hzmt+TuXdtcjZRa2patfaT5nSVa
	 h/n1q8AIHVMoIBKR7U6HCWmifMD6n4Oaliv9KWjNQcX0gSJPNF1aFgCCEnFWfYuz30
	 Q4YxVg6mXTW8Q==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso831566a12.1;
        Mon, 02 Sep 2024 20:02:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMCPdE0MKTZef523N2/m/L/WPsrlClkP0BoA7C/uLntg6Dyoi/h2prre1zk/GsXZl93IEJYOrQh5jijg==@vger.kernel.org, AJvYcCWVZqHQSOkt6El6DxYhtVbzHrsd0v6JmOtRpKWCrc+w5fwKS1tRuHPORtII+AKaE22YEnlYkAE3D5ZragrQ@vger.kernel.org, AJvYcCXWVy9Jj7/G45oH8nQE+vAa8HtkN2GeMvnY/FMk5zpCj1jE624bRQxVQqlchBNgnmY756Bzac6rgnrD@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2tpDMlnSnL4oFnw7TC3UratC1sHcYl8aSlNVep5LwjY4e0YM
	f/1DEBCvTPnSj5QC/1tsOOmE4TwLgflLItPpDDO18/+sy8a/PAU2rsApSDmGvfAHoz8j73uEvac
	WPJWHELkiTyw94gVmlf8LQIYk71g=
X-Google-Smtp-Source: AGHT+IFQvOmt/d4nuCLh90DtJTwLmDb8Y3D8cEuoZukN+Q7nq70ZJqyfeavEAM8ILYDJbhZxOnDULF+uSJWV+GWUIBw=
X-Received: by 2002:a05:6402:2114:b0:5c2:5248:8bcf with SMTP id
 4fb4d7f45d1cf-5c252488ce0mr6071487a12.7.1725332549402; Mon, 02 Sep 2024
 20:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn> <20240903015354.9443-2-zhaoqunqin@loongson.cn>
In-Reply-To: <20240903015354.9443-2-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 3 Sep 2024 11:02:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6kZcc=01BehCWSp3QT86y68X=LwVQ74Z-Tta_BjSqjrQ@mail.gmail.com>
Message-ID: <CAAhV-H6kZcc=01BehCWSp3QT86y68X=LwVQ74Z-Tta_BjSqjrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: EDAC for ls3a5000 memory controller
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@xen0n.name, bp@alien8.de, 
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Tue, Sep 3, 2024 at 9:53=E2=80=AFAM Zhao Qunqin <zhaoqunqin@loongson.cn>=
 wrote:
>
> add device tree bindings for ls3a5000 EDAC driver.

For dt-binding, of course I'm not as familiar as Krzysztof, but I
think Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml is
a good example.So maybe the file name can be
Documentation/devicetree/bindings/edac/loongson,ls3a-mc-edac.yaml?

In addition, I don't see any differences for different processors in
the driver, so maybe it can be more generic as
Documentation/devicetree/bindings/edac/loongson,ls3x-mc-edac.yaml?

>
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> ---
>  .../edac/loongson,ls3a5000-mc-edac.yaml       | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls3a5=
000-mc-edac.yaml
>
> diff --git a/Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-=
edac.yaml b/Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-eda=
c.yaml
> new file mode 100644
> index 000000000..52f10bc94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.ya=
ml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/loongson,ls3a5000-mc-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson Memory Controller EDAC
> +
> +maintainers:
> +  - Zhao Qunqin <zhaoqunqin@loongson.cn>
> +
> +description: |
> +  EDAC node is defined to describe on-chip error detection and correctio=
n for
> +  Loongson Memory Controller.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - loongson,ls3a5000-mc-edac
Maybe we can use loongson,ls3a-mc-edac or loongson,ls3x-mc-edac as the
only name here. But please follow Krzysztof's suggestion first.

Huacai

> +      - items:
> +          - enum:
> +              - loongson,ls3c5000l-mc-edac
> +              - loongson,ls3c5000-mc-edac
> +              - loongson,ls3d5000-mc-edac
> +              - loongson,ls3a6000-mc-edac
> +              - loongson,ls3c6000-mc-edac
> +          - const: loongson,ls3a5000-mc-edac
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memory-controller@1fe00600 {
> +        compatible =3D "loongson,ls3a5000-mc-edac";
> +        reg =3D <0x1fe00600 0x50>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38..6cc8cfc8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13237,6 +13237,12 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
>  F:     drivers/thermal/loongson2_thermal.c
>
> +LOONGSON EDAC DRIVER
> +M:     Zhao Qunqin <zhaoqunqin@loongson.cn>
> +L:     linux-edac@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.=
yaml
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
>  M:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> --
> 2.43.0
>

