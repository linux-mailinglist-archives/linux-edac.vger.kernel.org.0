Return-Path: <linux-edac+bounces-5281-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03980C28F2A
	for <lists+linux-edac@lfdr.de>; Sun, 02 Nov 2025 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F69D188C8F1
	for <lists+linux-edac@lfdr.de>; Sun,  2 Nov 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169341DFFD;
	Sun,  2 Nov 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TbxfNeCd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83381FDD;
	Sun,  2 Nov 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762086760; cv=none; b=IsdtrH1y/AYyQsIkXUTyzKqPOs5JC+a/wKN1J4sFecKwcy3mb04vvyJUyZjYfRsR+czsZDDi7T4nkSCwhdiCvHm+ooI0FdoIZjke0r4JS2p9a/XxABUT5JmZoHl4OZ1QRm5gUh6IZKOaipsB81sHZeps1wQuc4hcZeYD3KIGJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762086760; c=relaxed/simple;
	bh=f2sVVIMBHfKOhT4D+1goGS9xBz95JWAfpWeVV+K1ReE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUC2Djkq4Z7efoAEYyLbLx9oeWzoYTE5RHvG1gDqapL0100h2M90kgjL5Vvg7Xyc73TYpVWb5z5OLIyVOtEZUtZhxXcn/FzLO7p5a0fd/Lq4xVRfYmjVyi2MqznuIfstOXfIdmaDSDSlDy9IiYbn8yMleIX3qSH/ge/RhPk5aZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TbxfNeCd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EF88840E00DA;
	Sun,  2 Nov 2025 12:32:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oOHUlStEH83J; Sun,  2 Nov 2025 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762086747; bh=8RDLjRzC6Vx8GvHTKmNC9E43ohdNrQP1eOECZohar6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbxfNeCdaKrhqI44uPSqoV9T3E3k6fDNP8NGWfdSqEeG7eElf16RE3BdZWa92KhAy
	 6boaQBZSEgaqcdQiUP/OhggynQ6eMJF0LwI7oeVwVfvKIHl424w3DME7pK1YbsE3+7
	 EaEgkxD7R0syh4VUspU+PbEemlhGCwKmmWawWZU3fHobjX1+IJqtpfWjyrY3NNizAL
	 C4XI88ofY+j8srl5ZNZZfDYi9D/uUWqOVRpn/Kfk5NyAQjx4K0dCdJtthf1WxilWb2
	 mbuemC5CLCnD/+AWXSHa8m9Pv1knISlah5na0s5daueWAkCfIe4QBnLyDsUfKLW/7y
	 EYJqR4k9Uze9q7gdbZ3xd+zFAGiXPpdCVF8Hoc/TaD5o3S2q9W8oo6brL029Tgmirh
	 S253Y0CiRPmi2sA3+OBkf1EEHPabInQpvEkmgbxyiyDf2bqJ9LHpSbzDYf4ufdww43
	 QBPROhTM2RMochlF6ZLosEjC82CwiP94WlQZELZHjnQK8UGsLHyamWktk9MuzpnKrJ
	 aPDpjnaWW9obNBcQZK8tpKID1g3mK1NzxE6TVC9u965lChCfAXLS9tiEfjT1J12bVF
	 mY0XErexynvFevkFsp45K2/oqdgHcXTtqkUMs5pAylXQ4KS+7sXtk/0fqeTVHRhFXf
	 uRAp4pSZ41XuCUj+9YfCXXmM=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8BCE740E01A5;
	Sun,  2 Nov 2025 12:32:15 +0000 (UTC)
Date: Sun, 2 Nov 2025 13:32:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 8/8] x86/mce: Save and use APEI corrected threshold
 limit
Message-ID: <20251102123207.GNaQdPRy5uZWtz3Bfz@fat_crate.local>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-8-5c139a4062cb@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016-wip-mca-updates-v7-8-5c139a4062cb@amd.com>

On Thu, Oct 16, 2025 at 04:37:53PM +0000, Yazen Ghannam wrote:
> +void mce_save_apei_thr_limit(u32 thr_limit)
> +{
> +	mce_apei_thr_limit = thr_limit;
> +	pr_info("HEST: Corrected error threshold limit = %u\n", thr_limit);

pr_info("HEST corrected error threshold limit: %u\n", thr_limit);

You can send a new revision now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

