Return-Path: <linux-edac+bounces-1780-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B64969710
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4604E283F96
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F92205E32;
	Tue,  3 Sep 2024 08:30:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5B1DAC4D;
	Tue,  3 Sep 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352224; cv=none; b=cExbwHmY7Vr/uX52EN9tSIGPwKOdq9G5Dv/ehNfy7UgDcysUboYmZ3yzs2BTjatoUWRAVblL8I643BClYgdXDB/wgQG83hoU4v31lwNSQpR2OhQv74p/cSgYrawryvHYcTSgvGn57/un1FOJmHr8AVep0Xjw2Qsu6bGTTzcie9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352224; c=relaxed/simple;
	bh=M6JcT0iepMiXrkvVS8NhkD1BtIrnIm22E0HeLr/NOa8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NXoXfEdc3kcPiDveJ94xq6CRmz/lOO6o9ffBN/SBgUpNwoZf1Cu6tLbCRk+poMn/3KlklXWKpi1EAy15k5pNtDFDsBP1EmF3tJ1WLifypdsxR3GZiitYAzCJeEyTi3cA43q4R6/DGbcXebKq518VDMxiolhqAhbmt49HHd279DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Received: from [192.168.124.6] (unknown [113.200.174.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 872021A3F67;
	Tue,  3 Sep 2024 04:30:11 -0400 (EDT)
Message-ID: <5c0003ae887f2f80f7852498e1c1a3ff2c07129e.camel@xry111.site>
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory
 controller
From: Xi Ruoyao <xry111@xry111.site>
To: Krzysztof Kozlowski <krzk@kernel.org>, Zhao Qunqin
 <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com,  james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org,  loongarch@lists.linux.dev
Date: Tue, 03 Sep 2024 16:30:08 +0800
In-Reply-To: <979d67cc-cbd2-408c-a8ca-a063030bcec2@kernel.org>
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn>
	 <20240903015354.9443-3-zhaoqunqin@loongson.cn>
	 <jkdyayyjrzuhhfaueiessntfdof2m55xjxedkl3zp2jalf4sii@3fo65j64c6rv>
	 <549969b7-26c4-a203-b5a0-2e89ab7e7d79@loongson.cn>
	 <979d67cc-cbd2-408c-a8ca-a063030bcec2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 09:58 +0200, Krzysztof Kozlowski wrote:
> > > > +	select EDAC_SUPPORT
> > > I think you got here comment before. How did you address it?
> > I just randomly found a spot, and I will put it at the end(next version=
=20
> > patch).
>=20
> No, the comment was different. You must not select user-visible symbols.

EDAC_SUPPORT isn't user-visible.  EDAC is and it has been removed.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

