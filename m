Return-Path: <linux-edac+bounces-1714-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75F95A0C4
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A61D1F23C68
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64381B251A;
	Wed, 21 Aug 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I23JLl5r"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85521B1D6B;
	Wed, 21 Aug 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252378; cv=none; b=hwddexXwnecAA+BMSpANlUSb/f0hKcwmb8uVSLKZx7Sa/Sxm8IMCwgEx+fiebv6r7fjcIxK6pT3xZIgliwafhnrK6SZvi7KSmrootYlwQC5CCT1SJ7YjYnXtJERbVAj4kFDj3PKHbaZyow+3VoiD1qn95C2WCoYX74fQs75eMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252378; c=relaxed/simple;
	bh=BUOKPDhti0TU1HDgxuAIsHdwadzjlxbSiAgWhEZ/1NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlh7YErufes3O2Op/P1WepuH8aWwaNaCp/BTNBQ1t4c7lmxq21sFnk5khZWNfKEXty9doTd/sXNojW7MJlKxhOF5IiOosduBJIIq4z+neLuGE8YVPGozrnbhss4JZj70ozmUKoKKXGI8ttK8JeQFkACkLuuz/eN/Ye/TIkIhW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I23JLl5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC457C32786;
	Wed, 21 Aug 2024 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252378;
	bh=BUOKPDhti0TU1HDgxuAIsHdwadzjlxbSiAgWhEZ/1NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I23JLl5rAuH4WlGbirMRvAinLTJcdMryWMXE6g5+qEUusxyGlcDI70uUi+WcLNHQB
	 wCW1wYjF5r1mRdeVZc2O0fiENYDVnyWxhS737xTaJOzGkDByAK07e+pbkTSLvs8lBL
	 FSRXd8dGedKSQwtvTjtH3qoA/uOFxKmSSKuEdXs0cmbl2hKtIm+Qgs0359YDzdxrn2
	 vUoY6hxHRzAutSzU5wBn4//KTlEYmVvclqVypq0/fC20uDw1WkPpJqmPeUdXZmbBvg
	 A27gQ7mcV4Y63cd9Uh8PmyYol/4Azy0GNEB1t35pUntnxEzjZ1k23ZRYaoRCF+njv5
	 PwXD2tqlqiQUA==
Date: Wed, 21 Aug 2024 15:59:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhao Qunqin <zhaoqunqin@loongson.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: EDAC for loongson memory controller
Message-ID: <20240821-evasion-octane-891e772673f9@spud>
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
 <20240821064728.8642-3-zhaoqunqin@loongson.cn>
 <de5ffcd8-0f2a-4cca-a7a0-0c4fc0158392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EW2/+imsnmrdCVSJ"
Content-Disposition: inline
In-Reply-To: <de5ffcd8-0f2a-4cca-a7a0-0c4fc0158392@kernel.org>


--EW2/+imsnmrdCVSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:20:29AM +0200, Krzysztof Kozlowski wrote:
> On 21/08/2024 08:47, Zhao Qunqin wrote:
> > From: zhaoqunqin <zhaoqunqin@loongson.cn>
> >=20
> > Add: drivers/edac/loongson_edac.c

This is not what your patch does.

> >=20
> > Signed-off-by: zhaoqunqin <zhaoqunqin@loongson.cn>
>=20
> Please use full name, not login.
>=20
> > ---
> >  .../bindings/edac/loongson,ls-mc-edac.yaml    | 35 +++++++++++++++++++
>=20
> Bindings are before users.
>=20
> >  MAINTAINERS                                   |  7 ++++
> >  2 files changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls-=
mc-edac.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac=
=2Eyaml b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
> > new file mode 100644
> > index 000000000..29e5b8381
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/edac/loongson,ls-mc-edac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson Memory Controller EDAC
> > +
> > +maintainers:
> > +  - Zhao Qunqin <zhaoqunqin@loongson.cn>
> > +
> > +description: |
> > +  EDAC node is defined to describe on-chip error detection and correct=
ion for
> > +  Loongson Memory Controller.
> > +
> > +properties:
> > +
> > +  compatible:
> > +    const: loongson,ls-mc-edac
>=20
> Missing soc part. And then adjust filename to match proper (new) compatib=
le.

Please, please speak with your colleagues at Loongson that have submitted
other binding patches. Each time someone new submits one, we are back to
square one in terms of compatible strings.

Thanks,
Conor.

--EW2/+imsnmrdCVSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsYA1AAKCRB4tDGHoIJi
0mPmAP0X+UpKzVS4hoTHY6v2niMH9kvo2bGwT0gBareYLorCTQD/b6DLDKg0ykob
N4mBRGnbqXJPSL6i5U7DkVfu0UEBmAk=
=xbWz
-----END PGP SIGNATURE-----

--EW2/+imsnmrdCVSJ--

