Return-Path: <linux-edac+bounces-4022-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399BAC6E43
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611C816B740
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2F28DF0F;
	Wed, 28 May 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CsCXD0/D"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1BE28DEF7
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450728; cv=none; b=q47sphUahaKxd/kP7mtnvQM534uJgRyZC+5rP6YJl1SvpnYlg9puL5J6suTheTuasb4VB0cypEvDi7JsUX8NDao84/K8wJFzeCpg1alqzKtmIM4B+XgKpwziuXBoUk/l/ESl18Fp75dogs1OJafRL96RTgTvucw/3TzzRdmi5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450728; c=relaxed/simple;
	bh=znR5QUXE41nZihEXgns09QzMJjgKAUlISNko/uK0+5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSjs77aK3jcnfpR9K0hXu6whWyWuYHYU+Fq4Cnjlhozo8zASwR9iJVLynvOq9NzmUJBRZpjXcGH6E4reCeWIEQcvjYx+73MwhL7numh0VFNhJub1TAMEo1TUU//WxfirEKQNDeNQ4KxNGPnWggFLet4OmKxNJnZgk/NiMpg+CWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CsCXD0/D; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 769CD40E01B2;
	Wed, 28 May 2025 16:45:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3EFskOWPY-Jq; Wed, 28 May 2025 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748450710; bh=zsguAfVRolf6RDOz0MJdiGboChFc19f5rOvGbf7gZK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsCXD0/DwsK2RxgzmTrz1Qmdigy/PCDsE9GQIoOk6/crnCZ9OJtlB/MdRW7c7Lipx
	 1Ok2n7eELFK69SRiECPgD+djXJETS7pWVY54bUtjZTQxaTnEx8e4ZQZTrCZs/59U4A
	 DiCN8Oi4doCmLZ3ecI8cPGPxVDpEMUtBemnUXqd5eNzdu3NHsNGwitPmpvaviTzk+F
	 O5PsN3lKh73Aa3x8kE0PdKLLhoFXfXLIbH2GWtHf5KTGeu4xi/bFGN5TMjTArBEyGj
	 HzVLFCAbh8cN4lzXnRrDU81O9eyI8iUjlhdG+764KRYzgJk5JSn28yQ7HFrvnfBOnF
	 SWVrYd8kybXGrO4tezfFtP8q4qqGO3OTt/pvdjIbVRb2LgQ0UCbOi4HSQw8UQ9rSd7
	 jafHQtY7XqvDX49Xlhb4Pk86uiVEndD7Ox+Neo73ILA/vr5tWcBChRD88mr0JsQ4mW
	 EePug/rE6Umq71YEN764rZN8QDGoasO/8JEBgofFQK1/mCnvBBlyoU5e90rihoMwrd
	 EPYvZ1xIjzhvZWZI+OWhQpLTnX3iHBjt2bFzfFMBCqzV0l8w4KssOJKtNJKgvIolp2
	 ST+kwRzc49WleXuXvERBjm0yhQGaLL+SM9oK9HEmWExeC2CeW4x+Jy7RRZePROnBcT
	 8VRhPfljsZvAY2k5F8Kuy+R4=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B003340E016E;
	Wed, 28 May 2025 16:45:05 +0000 (UTC)
Date: Wed, 28 May 2025 18:44:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: James Blake <jamesedblake@protonmail.ch>
Cc: "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: amd64_edac fails to detect DIMM with only one ECC UDIMM
 installed (works with two)
Message-ID: <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>

On Wed, May 28, 2025 at 04:11:27PM +0000, James Blake wrote:
> Hi all,
> 
> I'm seeing an issue with the amd64_edac driver on a system with a
> Ryzen 7 PRO 8700G and ECC DDR5 UDIMMs.
> 
> When a single ECC DIMM is installed, the driver fails to detect it and
> reports:
> 
>     EDAC amd64: Node 0: No DIMMs detected.

Does this help?

https://lore.kernel.org/r/20250513192221.784445-1-avadhut.naik@amd.com


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

