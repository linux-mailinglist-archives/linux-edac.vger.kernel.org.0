Return-Path: <linux-edac+bounces-1624-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A116948B67
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409221F20EE6
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F11BCA06;
	Tue,  6 Aug 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BaIOUnw8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A016C692
	for <linux-edac@vger.kernel.org>; Tue,  6 Aug 2024 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933378; cv=none; b=H/IjvyyTpK2RADflM6DTnhbXqchmCO/oaxww1/DqLUr+zvNJQEe240pAmjxRwoklH0IsOBI5B7gLWmVzHCWlk6SSw3CUDikbY09g/26ZVnxIrnCfKtW0x/tYPF+YbbHxxE3nqQtcRytFJlGYKz+VLToHmLE9qX3Jap6lCvdTwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933378; c=relaxed/simple;
	bh=isWmInvF8zjF5zmzmODpnA8VtQPy/7l7Wo73wfwOeGI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AJN1cd7uirzBxj6gTcZFYebpKHG+ZHxeUtAw2Uv0HM6sl13LFKAUN4bJWWskeyR0xtBX53TKxWor+xaLNCv4aIOdSWhFo/xnAj2Ci4sx1rnG8wLq/noJY6C02+oQ/jeR0ffAFyip7e8t76sMhh1mmLpwhDqg8DsZHHRHlNER03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BaIOUnw8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1853D40E0263;
	Tue,  6 Aug 2024 08:36:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PBjgeXEXT0BW; Tue,  6 Aug 2024 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722933362; bh=VZFvU3B0MUdsE30lRLKXxTh4CS93t0dD+7S2kGCVcH0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BaIOUnw8uiep927zX+FK1LG973ZaOEv8QOzjE6sj5lhlvgaeEjdyQzB1fkjR0QZN+
	 /KkceWy3wff0ZtG8Y/xrtVrwfFN/dfMAp3XBJgw38a2OK7p37YqJPJg5oL2r44+fBM
	 HShKHLenBousdJ0sDBf6HEIYcyG31pFHfKiquyNeWxM2/FAIwRGA8gUZ2UmCCedHSt
	 lWUyrZN7HQoFBH3/AxgbRcDBO5d/Kuric2pi69DxyOzVhnw3+S/lW0+7mqsAQkFE3Z
	 qlPauHee1JIlg45/3XaP7xlL53AU+ixI33ya2afSLHb4BFK1khTeQpRaWe2P1MGJl2
	 ozmnARRtyvnGDXUSWnocIbMOXP0GLJxM5mnYZSotfigFJKzilKeSn+BXuF94+p2+8V
	 KqYV6JYcEj7qnvR5o0vtQQ3C+LRa6Nvlo4KhgBipoblOSVm2jaZTbGzqL/pFUqE43p
	 b3L5+YePUPYwfaCN4IV5iqo4ejJIP/avUTy/xy7JYLHd2LtPQmcmZLUfr6i4iR6CQX
	 JQzX5E3YUMVozIGT060I/Sic4jAqBcRLuFQ2ZjyYKMrFOlCyP3SRjC29zmpqzsaGar
	 P3P44UPqNc67XLNqNtqxsVyluiEJtxfW8yGKsHYeDryyZ4WMYgHADpuo7+ED8k71SY
	 7T4y4jsoFX9xjuxUeOGU++FQ=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:200:5769:7408:31de:2ee1:8cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D05140E0027;
	Tue,  6 Aug 2024 08:35:55 +0000 (UTC)
Date: Tue, 06 Aug 2024 11:35:48 +0300
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <kees@kernel.org>, Andrew Zaborowski <andrew.zaborowski@intel.com>
CC: linux-edac@vger.kernel.org, linux-mm@kvack.org,
 Tony Luck <tony.luck@intel.com>, Eric Biederman <ebiederm@xmission.com>,
 x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRESEND=5D=5BPATCH_1/3=5D_x86=3A_Add_tas?=
 =?US-ASCII?Q?k=5Fstruct_flag_to_force_SIGBUS_on_MCE?=
User-Agent: K-9 Mail for Android
In-Reply-To: <202408052135.342F9455@keescook>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com> <202408052135.342F9455@keescook>
Message-ID: <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 6, 2024 7:36:40 AM GMT+03:00, Kees Cook <kees@kernel=2Eorg> wrote=
:
>Since this touches arch/x86/, can an x86 maintainer review this? I can
>carry this via the execve tree=2E=2E=2E

No, we can't until the smoke from the handwaving clears:

>> While not explicitly stated, it can be argued that it
>> should be a SIGBUS, for consistency and for the benefit of the userspac=
e
>> signal handlers=2E  Even if the process cannot handle the signal, perha=
ps
>> the parent process can=2E  This was the case in the scenario that
>> motivated this patch=2E

I have no clue what that is trying to tell me=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

