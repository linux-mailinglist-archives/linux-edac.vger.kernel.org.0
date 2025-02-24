Return-Path: <linux-edac+bounces-3190-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB35A41E4B
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 13:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD81165D91
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3634261589;
	Mon, 24 Feb 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BgY5xZRZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445EB666;
	Mon, 24 Feb 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397857; cv=none; b=AvfCh8eLgsxNtFItRsKSYmBgTE31EtD5I8rkn00741wJiasypnibwlnEqz2TyAmum5AzA2w7JDQxJmSB2c5s1s6hycrx3gWZx3FM0te9ExX0Ba+jK6RlDEjarzEI5BMNde1u7kza+NOc7lvim1y/FCaaKhdcpKjx36IyVgakNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397857; c=relaxed/simple;
	bh=3pOmWWotVeFG7/aCwZCOGG1H2P+WnR8cfNlGlq4bbTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6F9wmVrg2CzG285igD+CWJPJaTaapbqtWITYftWUyksn6cMcI/ADImoAhQPk4Gp2vVOvA/wHwkhHIq5aGNgnYjeRW2Y8w1/OGRwwG1Bf+tKBAL7is+aLhQC5rcg2NTV+JjUNA/NXRYVvhDHBO+TLXh7wRHLe47eDbxcngrClpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BgY5xZRZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D08E140E0184;
	Mon, 24 Feb 2025 11:50:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ivEoj6-VbOC3; Mon, 24 Feb 2025 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740397847; bh=M+1Oj8yUN4/F9fqehf8NtiUeOEnlB2Q9pV11IJcCOkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgY5xZRZyyHcbymG/jlbXrNXaFXfSDbO8i45nhWQ2V37YX1k/XgK7zh0PMKMkh/iP
	 JYFV5SVHJhISD29fe8Yi2WfoH6Kzp3RyCBosloGJWp5RTwfexJRt3a3CnkJmHR18cB
	 GhXk1q7dyeHrU/i23LderkJ+mDkqvku0svXVEsTEkY9JC18UDrqB/aQgX9ThzNRJPM
	 QgyESfyhiO40lpHb8vxQeLATC+0od69Bzjp0SsobfmuAWUszuurHZOUshNXFkcIFov
	 InE6AA/L6TfQGfFqn1lseK3ejIZcomiFw0Daw2HxjeUbBHaUp+3t0t66J8bVftxgAk
	 V+f+tdNol9JQPvE4KuDd665W5Sop/JfoEpPE50eeS6LDsc9xd2UMOoFZ7nRNXFzwul
	 txFEL0mb1/Xih0owGH9mSNLqLA1kOpj8p+ZK5Om9DUeyv5dSIhI/dIVmv/3VQbrF9T
	 qRjYKNrrEPyD2jNI3oGF/yWLIpa+MBCts9F7kKiERC9+G3NRmogprmUACPJVbBnxDf
	 9HR3MVeMz/UJZv9MPlgq9wDm4fFHjOlRKWeUAOG1CD9hhOySbA3BM0ZafgJBWAny+o
	 k85O8qB1OeGz0AkxnS39MKSGpvtNYzaLjC9xHHnledxZC8ayNIBoA4yOuNkV1QKEN0
	 KIq8H30qDwp/QIbq1jk+8ab0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B2F840E0176;
	Mon, 24 Feb 2025 11:50:03 +0000 (UTC)
Date: Mon, 24 Feb 2025 12:50:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
	mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20250224115002.GCZ7xc6o3yA1Q2j85i@fat_crate.local>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212143654.1893-1-shiju.jose@huawei.com>

On Wed, Feb 12, 2025 at 02:36:38PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> The CXL patches of this series has dependency on Dave's CXL fwctl
> series [1].

First 5 patches massaged and queued here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-cxl

Please run them with the rest of your test cases to make sure I haven't
fat-fingered anything.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

