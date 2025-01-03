Return-Path: <linux-edac+bounces-2777-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C51A00BF1
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 17:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692541883B56
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815B81FAC54;
	Fri,  3 Jan 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aDKUfeM5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98424192B88;
	Fri,  3 Jan 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921211; cv=none; b=aTjim+QDyJJK+bldfuvgLUOqCfqMb18deFFT2cxbFKtjAGAbJBM0CIMRFU+GZDxh5DJNSIVRXfANc1LRB0mQNmX07+KNcw5NohUsflV3LWJuk9f9k73FTumTSx54lMKur/aKd4GGQSnG6J/r5wfxbk/eQ01NopqUDNzPa8DIoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921211; c=relaxed/simple;
	bh=aSP3EXxUVGG7FyIIBw6UEVeCGd0NyMb4xdDATEarYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbQupSjdopi16l4lS6ipTZ32/v32wumB80tZyJDRX+n7lsLok3qE0RhTKEOnfeu5WN69cfsSGNZJl4gn8FphBgoAoKES9JtX1tnvRdin21oSjVLii7TPJU+eJRDpFODQV+097by7a9l+6sKXfsewNjijjDRhb8gCNGalzYeElxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aDKUfeM5 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 891AB40E021D;
	Fri,  3 Jan 2025 16:20:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zbDNpsGyUdiB; Fri,  3 Jan 2025 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735921202; bh=pjfKNMdDp47GtpCrMArhq4IL4m/Dz9krRtWCSeb3hQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDKUfeM5Ikw9wYvbZkJaj5x9HD2HucjgNVn22mypHoIVX8bz9eNZwB18Y7Byhtmza
	 eIlV+/hTR/YU3otD03sNmNR/juEpQjYbPId9GtP8xW7OIim0WE/bo05aRq8ZIxCbn1
	 0ynVy1j4NhbQU0srjuMeEYB2ZewtGzQlyUM+4Nw7DkoYf37Zhs0/TskyLZuqslUFVT
	 4XGt2n3GlIwLi7rYOxdTWiJdPql48Cb4OBqZKV7ZGVowoyjnlwbKF74tuvVXrIJKdZ
	 FXE7zBtOfmH7JaAtHgmgrpCUYTp7WQdiw5PBfp7jSgSehn0mLWkH3ImjXa3MNznVe3
	 AJ4MukaPK/QkmJGrSfglphsHR+HRzoPt8ulgT9RRnrYWDc1Rqp+z8AEGQhs0PtWIBM
	 vgH8VADq+s4p8oaXPt9DKjn9SKq53kvOT/6tYLBvWDIE6rwzhjAgeQC7v2iOprEVGb
	 Lp8KCN76idiVRtWPNr7mBkh1LqS4qCgN0feO5E6dUcCuWTIjmT7wOdAuY44OYqFCGH
	 87GFFqgU00K9o7N8aFPRBWyR+I7eax7DLajYq6s4oQz0C0avrzbLtKOmm+S/rBUPFt
	 OC8DseaG2UgVizda34QSSt5ExczrgdhUueYph0x47yb9pYmOCiotWFsq8yhlKoGqul
	 AuPTTOCszmb9W064fNXHnNzc=
Received: from zn.tnic (p200300Ea971F93Ba329C23fffEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ba:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC40640E021C;
	Fri,  3 Jan 2025 16:19:48 +0000 (UTC)
Date: Fri, 3 Jan 2025 17:19:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: chenhuacai@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@xen0n.name,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, loongarch@lists.linux.dev, xry111@xry111.site,
	Markus.Elfring@web.de, Jonathan.Cameron@huawei.com,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V10 RESEND] EDAC: Add EDAC driver for loongson memory
 controller
Message-ID: <20250103161942.GGZ3gOHmenp37jlyyd@fat_crate.local>
References: <20241216013351.15432-1-zhaoqunqin@loongson.cn>
 <20241216115546.GHZ2AVQi9u5lABWboE@fat_crate.local>
 <2d4e5bd0-34dc-d781-3bd6-9eb7be2c1b17@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d4e5bd0-34dc-d781-3bd6-9eb7be2c1b17@loongson.cn>
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:25:25AM +0800, Zhao Qunqin wrote:
>=20
> =E5=9C=A8 2024/12/16 =E4=B8=8B=E5=8D=887:55, Borislav Petkov =E5=86=99=E9=
=81=93:
> > On Mon, Dec 16, 2024 at 09:33:51AM +0800, Zhao Qunqin wrote:
> > > +LOONGSON EDAC DRIVER
> > > +M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
> > > +L:	linux-edac@vger.kernel.org
> > > +S:	Maintained
> > > +F:	drivers/edac/loongson_edac.c
> > If you add yourself as a maintainer, I'd expect you to review and/or =
ack
> > patches for your driver so that I can pick them up.
> OK. I can review the patches for this driver.

Not "can" - I would need you to. I don't have the hardware to test and do=
n't
have the time to review them.

> > > +	new =3D read_ecc(mci);
> > > +	add =3D new - pvt->last_ce_count;
> > > +	pvt->last_ce_count =3D new;
> > That last_ce_count is just silly. Kill it.
>=20
> Then=C2=A0 I=C2=A0 can't calculate the error count added since the last=
 check,=C2=A0 cause
> what record in Loongson's ECC register is=C2=A0 the error count=C2=A0 f=
rom reset of
> the memory controller.

Can that ECC register be zeroed on each check function run?

Because this should work this way: every time you have to issue an error
message about how many errors were logged, you simply issue the error cou=
nt
you've logged this time.

Userspace tools like rasdaemon etc can then aggregate the counts.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

