Return-Path: <linux-edac+bounces-2684-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4479EB8FD
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 19:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D547E1887D1B
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90983204697;
	Tue, 10 Dec 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xnw88h3D"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6231204686;
	Tue, 10 Dec 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853912; cv=none; b=dynFiwLfN2fqMsXQTG5/auxr6q9OWeyGesEyBmLU838pN3DikO6SFWmGjMg7T2Zs4+UjkdYSIqvqpydWsTt3addsGOcujFD5SbeTzSX2XIfCHZanb/g6ic2v3XYS6bVBcWC4CXVqYbT4Y4zR6R2M5HIQjoJ/Dhu+mBunKORufgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853912; c=relaxed/simple;
	bh=z2LGdyrOdwT77YDmJ+kUH2F8LUR3Khe+4CixxN7FVqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRidU1Pp90DvlnSLNYX3XzOif3HitDPCn4qu+kv98sif/4qmxqgRZ9HXbZ7+b/aJGOibjMo/ToJ/nZTtm/FzSigeaaF7KGGc7LlanO/7MTdyvvN43B0EWAO54A3aSCwAs+2O7wWfp9Ba8z5L7Mz2UaGCwwpAcIUqflu59EU2PdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xnw88h3D reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 77D6740E028B;
	Tue, 10 Dec 2024 18:05:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UJAuxgaioa81; Tue, 10 Dec 2024 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733853903; bh=CXcv5arJMIUFP9rMdXwu2cvruK5rZq+dOIKJAl96sJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xnw88h3DGTdQnHAiAmP1g+BGgcvQ6FAdbx1BJDq1IGGjpQQ9M80t3CluOSrEvSmVb
	 Mfi/ARdRBq1BF9STTq/YOLqoZUjbePVk+jod/GgpKgjAQMuyQyJsYYfsl6q1Fb1UH5
	 OR9z8Q5TDecOWTZasXYbAEb2XsVssCP/67Q2+fdsnyt68cKE/rpShtexCB/ccblFKb
	 LUuWyCM4NXxAhKEYDBifSYdos+iCgO9ljWZHTwKubD4YfV/cBa5efXwee4SoB1ZSQV
	 ZCN2s5FFQyhzjVExerPgdybYvUGt5k/pXuDqwrQgZsEA7mrEmAOo/qb/lvpwGCn6WQ
	 zFnL715XT5vbJL6427rqVK//eopzzycwjlPXsut6P2n2nQRNYaUXWDFAgUsEfTwStH
	 i2+bjYbF5ILkiRDGPtV+Kqz6lyfibTs76vIE1yIW/bRiqmCfl77fpbUfZdsFo/qPDl
	 LpQbC08J5LaNjFdLrtllyWYldMXeBGdb5vMRIU2an5UQR0zLcfA8Sb35pN6VMv9Kf1
	 GipFygrqzvOMsuQH+jKQGJ1rYwS73cjpRDK8N2E6vluy+9F8oJCkIIk0jd+kHUCXBh
	 tMaW3tu3A7dKoR2RrzVdXO/EPii5cJs/jlFT7+2I+O3T3BTwRYlQgNWRXCG76MOtAN
	 nFcJUI1lMqHRtnxgbAhFteGM=
Received: from zn.tnic (p200300ea971f930c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:930c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56A8240E0266;
	Tue, 10 Dec 2024 18:04:58 +0000 (UTC)
Date: Tue, 10 Dec 2024 19:04:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] EDAC/amd64: Fix possible module load failure on some UMC
 usage combinations
Message-ID: <20241210180452.GLZ1iCxOTAL6eJaaH_@fat_crate.local>
References: <20241209215636.2744733-1-avadhut.naik@amd.com>
 <20241210095517.GAZ1gQBcS2BKA30-GO@fat_crate.local>
 <a3990569-ebf8-4c6e-95f7-851312ea823f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3990569-ebf8-4c6e-95f7-851312ea823f@amd.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:32:06AM -0600, Naik, Avadhut wrote:
> But not so sure about the CC:stable.
> Quoting from stable-kernel-rules about the patches that are accepted in=
to stable.
>=20
> It must fix a real bug that bothers people (not a, =E2=80=9CThis could =
be a problem...=E2=80=9D type thing).
>=20
> This has not been reported by anyone yet. IMO, it classifies as
> "This could be a problem" type issue.
> Would you agree?

So if someone populates the last 4 UMCs, he won't have EDAC load on long-=
term
kernels. So are you sure about "this could be a problem"?

Or is it more like a "this is real problem for some configurations" issue=
?

IOW, at least "oh, that's not good" issue.

Or?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

