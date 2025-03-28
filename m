Return-Path: <linux-edac+bounces-3414-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72501A74DA8
	for <lists+linux-edac@lfdr.de>; Fri, 28 Mar 2025 16:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197BD176BE4
	for <lists+linux-edac@lfdr.de>; Fri, 28 Mar 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98A1D416B;
	Fri, 28 Mar 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UeD0uFS9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676B4204E
	for <linux-edac@vger.kernel.org>; Fri, 28 Mar 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175477; cv=none; b=XpIIShZfO9eTWzDuegoW7PxBezvd/OYQZCKJj2SsP5as/MYtuj5egZ6pT8jzN/K447+4azGupeJqOojz3yCl+aCeDWCED7QaYns+Py0ChqQxLSCHO5AaSF/wtKmIWBco21NChi4YGN5K4d35RgXnRUHoxWKaUs0mH5TpCosoewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175477; c=relaxed/simple;
	bh=VA/ZfcD1YB1HQ/zRD9C08+WDmsE0nw9iaka1ilB6ECE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNCeH7wveUmKMJnKaAUejvBfrTkIl/pqP6cHpy07njM0VZ4p5Hlr6HUfCCziHuCFrLNAooTJCS1TIqxcTM/fqGcpdkxCMlBSc0cp3+YLijEYkHde2Wq3XPdULgUYqXjNnmxn8Fw37+XtEKyHo0haVm+f9szhLAZfio3iG3dCOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UeD0uFS9 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4858E40E0215;
	Fri, 28 Mar 2025 15:24:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qDddVM1RD3ad; Fri, 28 Mar 2025 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1743175466; bh=lHSkzhGvpnv8DNeYZdX+O0JWzJBBHfsIMsc9MFcQ81g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeD0uFS9MmDmzzHEjR4q6c+3KFpKCTkVDp87YN/3l6Bg3oBeyvEet/BSiPqhXSKit
	 GM5vAz21p/PHIQFSfuhm3ROylLbdv/5z21MlcrgJ/x4lChGgJNYpMNwS88n0kp+E2Y
	 KlwBP++ZOOJcp7/HP4MEuHhlRbpiuPgsGB0SHXwF90S3wg+XTb/x61BQu9BR6MclE3
	 KaiRPulp6GiwQJp9VEPH2YB+JSFaaeTgIvvCezNduFfK4h+8UJig7EUK0fRFKVCpWn
	 tLOe2r0fbVBTFV1n7kljL2H/+IHuvbaNrKFFsOQvT6SOPV/VPwAPXach0j9XTz/sNN
	 C8EzlQF5elSPOAxHVtLEMznT/Jgd1wy3Q57UWejJLB6cNoUabs/zgkWU8h1FEh7T7G
	 f3Dj2iv30c8lRkx/NQTUcGCOsRv1a5m6qIZbTFe8y7baVukxwTybVZgiSntBSXIQjy
	 mwioKTfMRypI5SlUjabiw7w80uPRSR19BoxE9dJWfjUOD/RWPiX1x3yP5RFQ2hOc6K
	 sTlMAutNCgj5vA8Tu+aOFHxLItjcwpHthiLMKnjKkdVWw8/m4qixw453f2biBQH0zR
	 H/kcsvnp3qsq7d85CXKlF+5kHfqEytUObmIH7T9Qx0BjTX0HAYpcYhbd6WIaeOdgY2
	 yuDxRyXzU4qrmiXQ1dvDdkqY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E19BE40E021F;
	Fri, 28 Mar 2025 15:24:20 +0000 (UTC)
Date: Fri, 28 Mar 2025 16:24:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
	mailinglist@reox.at
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: Memory controller not showing half of the memory?
Message-ID: <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
References: <20250317120702.GA7066@yaz-khff2.amd.com>
 <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:38:58AM +0200, =C5=BDilvinas =C5=BDaltiena wro=
te:
> Hello,
>=20
> I am also having this "half" memory problem - EDAC is showing 48GB inst=
ead
> of 96GB, however otherwise whole 96GB are usable by OS.

Both of y'all folks encountering this issue, care to run the below patch?

https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com=
/

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

