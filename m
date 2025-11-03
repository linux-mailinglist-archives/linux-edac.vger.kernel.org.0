Return-Path: <linux-edac+bounces-5302-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5EC2E217
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 22:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7943B5EB0
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC02C21D4;
	Mon,  3 Nov 2025 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hQZDHvhs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F042727E0;
	Mon,  3 Nov 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204747; cv=none; b=F3OIflfsB5qAlXTN76oM8oNsJJBTo4yYG2yQbtVLiUl07rE76Akaw6pe2Ccr1wrNvXFPrYFoR1DZ6QcVxS2Wnp4o9FUM1nvKGrNLrGzVetIe/YnW3jaWzmCLkWDAEIYPg60TePeYKuQXIZM3DioUE/UZCaAykrzILhqkxSf3wTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204747; c=relaxed/simple;
	bh=nBlIqUBdU7S0uUAsbByeETu/nNTolWO9OupApZs/v6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIQ9eTwoCCdhz0OPknwqDTS3lo0EnR04gtrVyYCbUaT31ouSg1AC+aly9zFex/JAYQA8SaXoHJQMXKo/vYXrZQjy5qBpG4U6qFauEWq/0yax7GqXUVATvNO36Z7BHoXV1fEjDHhILg1pVqmOtaTXSugT7PhRlARzBC8tXXSC000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hQZDHvhs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 69A6140E015B;
	Mon,  3 Nov 2025 21:19:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vtdcvIT_5Y3f; Mon,  3 Nov 2025 21:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762204738; bh=SKb33AtMRwS1nbzZAQG5/MWSKhGIXLBg/xEjWPaXbx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQZDHvhs/pDLYMENDSth2N9j5dnlbn6/XcuGSfWIAxM0RdCDBu8W/34EnDbUe30r4
	 ZNej0P8gwvftxrCk//vMVeTNc5bUIBIrwZUk32igUJwkBeziYJd1xihqMQs4vVCLHb
	 9XQV0IKdmudXSLjQ0YKuiXE+SEDevaG3VBOtjmL3X4iaeM43PCXshX6HPzjH9UAqEB
	 fR6sXEQpby6Lh/CFQGzIcpJdaY/WtpM0wFSSNu2/dwmaa9YsA8xMl6lgkBw7CV99Al
	 L5tUJ2NhFYy8L6yEJQit1ahhTKkOlClPwDpsXzBGa0KxepqJD6z+BkxI6+/aYPDW5p
	 V3MMcHqAw/673JQwwURqMHpo7ewBD69Y2nxsXIYPVVG9PlH7vA312EXBGos5JpMqrT
	 0rMEZBIsBqfg57Q9NQrZBY5p+qc0cB7vWJ/MT+xTCN1rOJXY4C1sjFCgafRKwd47S8
	 8D6Oc6QhV/GmCW2QU9UErue0wxAVptVcy6AeQtvxLAAvUkuw/mq4vhZI01ZJwv45gp
	 rjNELiOKeS6wLlP+niHUtBla/ydu0RXjGi0EgJg101gF6BCy8zoleZ8lGIbLGC60/Z
	 7hfhmVLqpK31y+6xGQq/y2URkJ3FsNovJemCRino+YuyO1FdCZgMy/5jR9P7det5oQ
	 UPvhqx64C359zpjRE7CqpsjY=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 06A1840E01A5;
	Mon,  3 Nov 2025 21:18:53 +0000 (UTC)
Date: Mon, 3 Nov 2025 22:18:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] EDAC/amd64: Set zn_regs_v2 flag for all AMD Family
 1Ah-based SOCs
Message-ID: <20251103211848.GNaQkcOLw5vUhq1jTs@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-4-avadhut.naik@amd.com>
 <20251029171057.GFaQJKoUUKI_VM2GXn@fat_crate.local>
 <20251030134839.GA3209@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030134839.GA3209@yaz-khff2.amd.com>

On Thu, Oct 30, 2025 at 09:48:39AM -0400, Yazen Ghannam wrote:
> 
> I think we should take any opportunity to get away from family/model
> checks.

But we're not getting rid of them - we're just partially hoisting the
zn_regs_v2 assignment for some only.

This looks like an unfinished patch to me so what's the point of it even?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

