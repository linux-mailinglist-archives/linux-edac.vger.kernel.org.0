Return-Path: <linux-edac+bounces-1435-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99791C165
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A133281698
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7C4C3BE;
	Fri, 28 Jun 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="USazIl4K"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8743FD4;
	Fri, 28 Jun 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585930; cv=none; b=MiApb57CKgJK1ki7MDthAUJjWCHHP/O8EjALiRivoLiF+ggk1k9LimCOxmK7X84cis4rbSN0ZEDmyikyaxU/hdvlRi8fI+UvP6xcjKM+ChGxzOPP/TsDb9DS3gStKEbatAzd67nZdBsWBJsdNQDQ0uknfBpmrsYBt8aX4BZu1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585930; c=relaxed/simple;
	bh=aICuprWnSjP9eScCzHB3FMUjG8kNJF3xR6iAE6BPq08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7g9on3Px+ZRiAWyVdQDLPGYS8xReARixiCA6MKhSigx9ASTpyVNlUTt1hwB3pcbqikAaTUXe1TfD+Wz3dKDAb6Ef2hg+7bOmtCmJLJ+I1YeFG1kHK8yE7aHgoeU64GpEbTI9vR5GyrdBrP0FM29sL30+4PtDV1M6vaP90yz0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=USazIl4K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 439A340E0027;
	Fri, 28 Jun 2024 14:45:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1EkaqO1vDdWG; Fri, 28 Jun 2024 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719585921; bh=g878iQcJ2TWlDYARgfF2E7Nv6DYEvGZ50sNVanN/6IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USazIl4KIKWFGJggBkcn4pn9HbQL+ZTwfgEYfzyzVCSUcYSjim2PUX/NrVS32WgNL
	 uuq8LrVYkMp0T4ubO0S4wIEmihMmrBOLZSxMpP4bjTV+6bjifMY5Up1H6hqzr9tU5Y
	 3OhSK4bZS3N6oiclMAjabZhKgWK/TJ+XZcUWpgnMkncqy8OXqaqBxHcmMxDOjFZFjA
	 soGytd/vrG5sKCvaZxXL7D+imGHKYdT6l8fsGz0Nq2lIGI/Hxnplr2CJk9SptW1+/u
	 QRs6or3+ERwtA3lOVCW5yHjWEvHIn+Jqj/MygxFIoV3ayyTOw71N8yOypTn4ylIniX
	 tiYnqoLbm01C7x0u+64mGRiLlwWA+twu2efmwIWfJQig6bgwXeKpa0v9wL60VNTIyd
	 uejLl9tkfsl9ApR/1HK9PlQlz3gMrvuj1zV/uufLidJ3Tf+8Cg45cLJ1rLeHk0mYY6
	 yoIGwJ2SR59k4x3o3riODckeoZ6HXcUqJ54D95YID52tQWCz/xkr39LX4ixolzkMvO
	 6ZIwiFjnQjecqh3Djc5n+wruOCarUP0o6m5lyj3GguxVZkV/D3D8DGcnqaYKNXnuDQ
	 vIgCR/VXBrKWGlOp03J7JSvd/6v0D9erTLKla9hT7Wba90sCGBAvplhS9GM7QTHXCr
	 STL1xVkn3q4lCPrsq/uZe8fg=
Received: from nazgul.tnic (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C48E40E0187;
	Fri, 28 Jun 2024 14:45:13 +0000 (UTC)
Date: Fri, 28 Jun 2024 16:45:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
Message-ID: <20240628144535.GAZn7Mj4jofP3Vz2xf@fat_crate.local>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
 <87ed8l7byy.ffs@tglx>
 <20240626014212.GA1086@yaz-khff2.amd.com>
 <20240628083722.GFZn52QnltR_2gjuO5@fat_crate.local>
 <20240628141542.GA124261@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628141542.GA124261@yaz-khff2.amd.com>

On Fri, Jun 28, 2024 at 10:15:42AM -0400, Yazen Ghannam wrote:
> Thanks for the tip. It looks to me that SMP and X86_LOCAL_APIC are
> generally independent.

They are?

config X86_LOCAL_APIC
        def_bool y
        depends on X86_64 || SMP
	^^^^^^^		     ^^^

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

