Return-Path: <linux-edac+bounces-1505-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D131C92F552
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 08:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003C8283E5C
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 06:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEA13D2BE;
	Fri, 12 Jul 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mDsbVsSc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Iw3rgzXw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B51913CFB0;
	Fri, 12 Jul 2024 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720764493; cv=none; b=UjJkuPGvJ1vcdSh2z1KxMqKlt6FGHz0xQp1EFVGiUQFCnYjg/S6UtSPR+I6HzLA29U5a+L3A1CimpGuskBEv0YLcwAOJxKsnYI+6naudabuYBKO6vKycurg5z6+ztTGH3oJbWiuSCd2N68p7vNrKXpzaMdqstijzQNk+rgd7JDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720764493; c=relaxed/simple;
	bh=oOmEa1P3IKAGNFZfngYwKWSd+Br874qTAS3G64tjdgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpm5HMT6Rb5mbjpg+rbBFpJnyleVNEIwiiFxvNZWxQ9C6sZFQ5PJf8TAACLUczNkCy3tMs2grqu6ti7Et7Azh0nEEJEGWVGcRHrBgFUTTgow2N7eH4cT6XPXtimIdTl+emBwJqXkty2cBTpD3NeENGrWccLkVDfaju3W1/d5xjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mDsbVsSc; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Iw3rgzXw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720764490; x=1752300490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9kkQv+TWA9nQxOn83JfnaiK6tbtRd6yY1Ho2RrmzOk8=;
  b=mDsbVsScVdKKgYBwbcr1mDt3/KlIGcGMEqrMiJ3SalHS81TR9aGmz5z4
   xmDQ7jvIcWAXOBUbZV+6O2fYBNuJQL7gC265XIpZmUnzegYOx9MwgWs1k
   6lu59rINPvngFPARsxboe7VET1CD8cRtqtG3UA2OLH6dl7zBPPCsbSZ8P
   I8Sl7aHdmUnbfFUB2jlFILZnlPevmfNx7uxqSFE50t6LbbsA+B+RUVK27
   oWQFw5s2eJEI8d7W97jnFORjW2AHJJOFrD9in4G256YG84+VN31hoN8tw
   ekK3RyM2Om7IqDqH6tqQB3QZk5yNVnW7NB6h4dl3BKR3NxEa1W4V/ygz7
   g==;
X-CSE-ConnectionGUID: ijGMlMZrQLCwQSsfFBkBGA==
X-CSE-MsgGUID: WHEqB7i0TnWd7EzlQqfYBw==
X-IronPort-AV: E=Sophos;i="6.09,202,1716242400"; 
   d="scan'208";a="37873063"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Jul 2024 08:08:07 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52BBA164423;
	Fri, 12 Jul 2024 08:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720764482;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9kkQv+TWA9nQxOn83JfnaiK6tbtRd6yY1Ho2RrmzOk8=;
	b=Iw3rgzXwVxbizrITOLFdZrD4PgrE4WYEVXH2U1xJU22JJlPxDPwZT0Ln3X2D39D3/OVq0H
	NMSJtR7dk2P5Q8q9IAUxKISScCl0yyqorESNhHIpls3ZEnzL4X8V4b841BSMvT9FZPkBL0
	9OUkMah6RNN7JSX17Tr1Ab+uo/A6OFKOT3twFgTrppGv0UwHDFas0rC+HqKC+FGVWHLjh3
	NgyIsu/WAQ1nC0jfM68bXOEhwTP9IioSK6S4L5rZqWwVpaN5btSdlmhhjg2oEPUmanRtwx
	gaUKJ+srN3w/VIrpEQfA+9agpZmP1OY9BBh2xbh/NNSeyul+Io72Byez+gQF+g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org
Cc: York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH 4/6] dt-bindings: memory: fsl: Add compatible string nxp, imx9-memory-controller
Date: Fri, 12 Jul 2024 08:08:05 +0200
Message-ID: <3238685.5fSG56mABF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZpCiujvOKJpz6/JU@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com> <6068670.lOV4Wx5bFT@steina-w> <ZpCiujvOKJpz6/JU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Freitag, 12. Juli 2024, 05:27:54 CEST schrieb Frank Li:
> On Wed, Jul 10, 2024 at 09:18:16AM +0200, Alexander Stein wrote:
> > Hi Frank,
> >=20
> > Am Dienstag, 9. Juli 2024, 22:23:05 CEST schrieb Frank Li:
> > > iMX9 memory controller is similar with other layerscape chips. But so=
me
> > > register layout has a little bit difference, so add new compatible st=
ring
> > > 'nxp,imx9-memory-controller' for it.
> >=20
> > Is this controller the same for all i.MX9 SoC? E.g. i.MX91, i.MX93,
> > i.MX95 and any future variants?
>=20
> So far it is the same. I can't prodicting future. Not plan to change it
> yet.

Okay, thanks for clarification. If DT maintainers are okay this way, I do n=
ot object.

Best regards,
Alexander

> Frank=20
>=20
> >=20
> > Best regards,
> > Alexander
> >=20
> > > imx9 need two 'reg', one for DDR controller and the other is ECC inje=
ct
> > > engine register space. Keep the same restriction for other compatible
> > > string.
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   | 31 ++++++++++++=
+++++++++-
> > >  1 file changed, 30 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl=
/fsl,ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fs=
l,ddr.yaml
> > > index 84f778a99546b..e0786153eec73 100644
> > > --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,dd=
r.yaml
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,dd=
r.yaml
> > > @@ -40,6 +40,7 @@ properties:
> > >            - fsl,p1021-memory-controller
> > >            - fsl,p2020-memory-controller
> > >            - fsl,qoriq-memory-controller
> > > +          - nxp,imx9-memory-controller
> > > =20
> > >    interrupts:
> > >      maxItems: 1
> > > @@ -51,13 +52,41 @@ properties:
> > >      type: boolean
> > > =20
> > >    reg:
> > > -    maxItems: 1
> > > +    items:
> > > +      - description: Controller register space
> > > +      - description: Inject register space
> > > +    minItems: 1
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: ctrl
> > > +      - const: inject
> > > +    minItems: 1
> > > =20
> > >  required:
> > >    - compatible
> > >    - interrupts
> > >    - reg
> > > =20
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - nxp,imx9-memory-controller
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          minItems: 2
> > > +        reg-names:
> > > +          minItems: 2
> > > +    else:
> > > +      properties:
> > > +        reg:
> > > +          maxItems: 1
> > > +        reg-names: false
> > > +
> > >  additionalProperties: false
> > > =20
> > >  examples:
> > >=20
> > >=20
> >=20
> >=20
>=20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



