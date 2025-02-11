Return-Path: <linux-edac+bounces-3028-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177DA315F0
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B9E3A6FE5
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D692641C8;
	Tue, 11 Feb 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="l4Ct+vva"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EE2641CA
	for <linux-edac@vger.kernel.org>; Tue, 11 Feb 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303269; cv=none; b=dGx5POsgDOpaTNVGMKLEJfLC9A6W/ozfuC4QlTlUWUXll3Eb4rKPLxLwP+Svj/uALd30fokLAhq7IwWTNKXpaPRhnK/gVUfvUlkP0j+xJTPicf2nDvx1nNgkbRtVypiL0XIT+te19YP8nWKGO6BLQv65EdW13u64YX9aIyXjkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303269; c=relaxed/simple;
	bh=znK53Dj/euVHWQdgD09qcZZGySMwbQU2qY49MxYGshw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVOcWxBNgoGhc+jQrFXyqzCJAL98lz8DkO1t4TyAlnb3AFEUJYMAjOgSFmw4RoUOjk5sAkyUvsIzqh26j/iNAdtZSBEhT8UoW3PaocrQGpokVILn2PnzQYF898N0Z5MPmf6ddtAp+6RutYa9MgHbudV3a6jQAzSIhBGJnLu2+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=l4Ct+vva; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739303252; x=1739562452;
	bh=znK53Dj/euVHWQdgD09qcZZGySMwbQU2qY49MxYGshw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=l4Ct+vvafxZ1n2OgxFRxjbYJVoAAJZ2xgfA6nNICfsFlRbeAYSYRUeKw73ZhHfkgw
	 oaRK/jkThfuf3+Ib/PEP9gaBMAxrnYJVMNdcahFWfJqRVayWFfCdQqOiXUqm+AIbuH
	 E8n87GK2uh/8w9voGMFgL/0uftPhrBOCWecj348M5NqRNE6cUnMR41GH/X3igca/P8
	 ELH+dpuyMwXEo7RHwd7rD9fcDwYZJh2sZ/WEvLNK8naqnyVP2OLPvkG7UvR1fx3qSy
	 GA2EqDYYKv83lMv3BalGcyaAH7bbWrp6sWXyQ0Em30y5fZjbVHKdihnPrt7KgZFzQn
	 OJt8zGmalAhaw==
Date: Tue, 11 Feb 2025 19:47:27 +0000
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
From: John <therealgraysky@proton.me>
Cc: Ramses <ramses@well-founded.dev>, Linux Edac <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
Subject: RE: Flood of edac-related errors since 6.13
Message-ID: <5Suws4N3ohcTi4z3uWVYN16n4119blnT1QL5qAzzj77LVEIPTO624pJPaE4Wj9kRdUUtUhAw_rM6tHKHXdSw3NtP4uPec9gl1wNFWUPDDYQ=@proton.me>
In-Reply-To: <CY8PR11MB7134C4D5D727A523F8F3CC8D89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <OISL8Rv--F-9@well-founded.dev> <CY8PR11MB7134594FDBF7AED80E415AEC89F12@CY8PR11MB7134.namprd11.prod.outlook.com> <OIUifRt--F-9@well-founded.dev> <CY8PR11MB7134358940D4625E5196349B89F22@CY8PR11MB7134.namprd11.prod.outlook.com> <OIj2FiD--F-9@well-founded.dev> <CY8PR11MB7134C4D5D727A523F8F3CC8D89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 81dd34a84eb900c66eaa54745db0cb866dbf10e1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, February 10th, 2025 at 8:55 PM, Zhuo, Qiuxu qiuxu.zhuo@intel.com=
 wrote:

> I'm waiting a bit for John's test result (if he has the chance to test it=
).
> After that, I'll post the fix path to the EDAC mailing list.

Confirmed, your patch fixed the flood experienced with 6.13.2-arch1-1 on my=
 Beelink EQ12 (N100). Many thanks.

