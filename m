Return-Path: <linux-edac+bounces-4244-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38DDAE8717
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CC37A70AB
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272E1D5170;
	Wed, 25 Jun 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HTfLNVsh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA991C700D;
	Wed, 25 Jun 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863092; cv=none; b=aKbw0wYu0uSw+p+BDk1XH09Y5XBpsiEpybE8jOXO/5kG86ubcCwaqbQn5LCe3Ngj0zxQJhNVsHKY19TSG0sa8Fk2WsdJfdpW95S3qWWIhK54Z+x7mqGXiFpWJriCb7Gx5Xjb4EGP0GrwctuyZI76bz0IiX6Qrptbu263U6vqRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863092; c=relaxed/simple;
	bh=IDWtsE1ssLqJQnHo7vMwKeriRpXiA/AjZryWJ4ogYrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BERbZ2yRUSzgveD6hMvD5vfNCQ0wCS5wrJh1T9S3CD3VMTwHxCnWsUsUySnjx3f1e4OEo/kDW/mppVgFaT/nUFYX+4+Eyz/22XbmcCL6jBve5jPxAToYKPUAlQJqxlduQNIZ57Gz7OHFgKn/1gYN1lSFttGPQRQ3c1MKF1fX5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HTfLNVsh reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DB65940E0198;
	Wed, 25 Jun 2025 14:51:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qd9_5t7BL3pK; Wed, 25 Jun 2025 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750863081; bh=mSgBljJDSSPgybtfgKcZuc5PlEdCsjmYII4xX36X82Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTfLNVshad0nNM1r0zJA4kAoroUiTeD7RVgpfZbBNYM0uqtc0rFst+jltnkhRgd+N
	 7HgU0nhDkLjQWKSMH4SmvBcj01iqg9wVq0RMTs4vBpCiExzUmPN2CT2plVUw9DTThz
	 d7j3cD5S8fQycvh7eEXIiPH9mpb19m3Z6yPL8BPHXOemYkd2rqn0DFqaTPUv4fjrQx
	 YbjZt7A2lETbF2LeUJVwfP/qmYa7WTCt2K2ibP+KR/24yl4pZTKYbYHoekeBBt7V7a
	 YUk+D2ABQk0mK5GwwGuEPBgpUF+o1M3OPCdKdPAwLyLddd0KwbVi1FqP7IYsXGDUdH
	 ypWtbsfewYOdXgIS5etJBB/5F+GOXKs4yPC7/ZgS3x4pMiX/YUrVPAlbI6lbQ7risa
	 T9+/DKBg7GrXJCt+YNOTr7j6omrUORpIJ5gNqu3JHDz012CHSSg+KY4HmrSOA+5IqD
	 /AKHpiUx2L36crWyZ/+AD7SYvvCqTYeAHr2oz0ASCoCW7AlafZE9sljGBv87GT6PW9
	 Hv0LVG5lB2Ctm+PAa1DVr/dN1iOujlNy88K6y0HqeeBddhKlVam7o1XxZt2aZRKuAV
	 9k9ME8LCvL7LbKjlt3rlJqlNvUoe2cyPK3xGl4riHHei/nzTVGbyxJPnbPFOva5TAU
	 xmXxsxzRHGy7+iQ5/wS9Xuyw=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 879D540E019C;
	Wed, 25 Jun 2025 14:51:16 +0000 (UTC)
Date: Wed, 25 Jun 2025 16:51:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
Message-ID: <20250625145110.GAaFwM3ooyoFYsfgsf@fat_crate.local>
References: <20250529205013.403450-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529205013.403450-1-avadhut.naik@amd.com>
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 08:50:04PM +0000, Avadhut Naik wrote:
> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
> modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
> register associated with it. The amd64_edac module logs DIMM sizes on a
> per-UMC per-CS granularity during init using these two registers.
>=20
> Currently, the module primarily considers only the Address Mask registe=
r
> for computing DIMM sizes. The Secondary Address Mask register is only
> considered for odd CS. Additionally, if it has been considered, the
> Address Mask register is ignored altogether for that CS. For
> power-of-two DIMMs i.e. DIMMs whose total capacity is a power of two
> (32GB, 64GB, etc.), this is not an issue since only the Address Mask
> register is used.
>=20
> For non-power-of-two DIMMs i.e, DIMMs whose total capacity is not a pow=
er
> of two (48GB, 96GB, etc.), however, the Secondary Address Mask register
> is used in conjunction with the Address Mask register. However, since t=
he
> module only considers either of the two registers for a CS, the size
> computed by the module is incorrect. The Secondary Address Mask registe=
r
> is not considered for even CS, and the Address Mask register is not
> considered for odd CS.
>=20
> Introduce a new helper function so that both Address Mask and Secondary
> Address Mask registers are considered, when valid, for computing DIMM
> sizes. Furthermore, also rename some variables for greater clarity.
>=20
> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
> Reported-by: =C5=BDilvinas =C5=BDaltiena <zilvinas@natrix.lt>
> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@na=
trix.lt
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Tested-by: =C5=BDilvinas =C5=BDaltiena <zilvinas@natrix.lt>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org
> ---

Applied, thanks.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

