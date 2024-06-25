Return-Path: <linux-edac+bounces-1364-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375D915F14
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 08:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87736B225AB
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 06:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E41465B8;
	Tue, 25 Jun 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sj0CWA9k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JoXxl9yf"
X-Original-To: linux-edac@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2C1465B0;
	Tue, 25 Jun 2024 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298250; cv=none; b=JoIR41tRSv+15cHaaDaVT0Vmcmp6/ZQt5dJ8WEJKPa7W6iOZDdWmT+3Babv7+NxBykLjZIgTSB3RRrCFSEh2BEG/T3Uhj7Hb0VTya+pjJEcG4TIy/f3rUdAz0Xp4dpCqY4VR8umLeIiwUxsySt90kjm6UyrPVDQopBshpw8kwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298250; c=relaxed/simple;
	bh=fikHTFWKbzZzSb/FoOn8hq16I7pD34RL1CC8W8j3AeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJSwD9GN1Dr6C1/50o3eZSasu3KKpm4MofbeWn/ij5TfTf4cSO/2F67VWblvyjNTl1n01pRgGS+K9Fh+a8hTJWyulvJabMrgmfUDyZzGD9QH96b13HEEx+RDSqclcDLD2HHJP6bBA/TYFRxXtpWRCjXLVUafN48KjZ7MoeMSEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sj0CWA9k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JoXxl9yf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719298247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLMYTeh+AVC62umqv+l1zIOiewS40E/iV4WtzskHxs4=;
	b=sj0CWA9kgz1So/43Nh/aBvNwbdzvk3QJdmpaEbr+OEbGwcDtkp/z+nPi3VKsVoYdvczFzP
	irIAjSaoeyfINqU2l/1QXfpV5L9nFfHY0h761OWVrKB+tEqIOemcU9d2irj6hT9G1pIQ7e
	1YkreWj0Qj7gIpqkiAVCbT72XSFeLwU+NtpDMbHxTUFMgspI+Wx/rxjn+QmrI7bl+VnV29
	lrj7ZdsZDCjUzr3y3q10xOjrdQGZ3GgyLmJH+NgHIG3DTfsMvEhdPgn2B7GLfDH/E8Xm5N
	kgbGGwcdds5e1MskRRTqDACx+vDR2rDxO+llH3PZvwVUBMYIpyT2ZtdUVKwjpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719298247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLMYTeh+AVC62umqv+l1zIOiewS40E/iV4WtzskHxs4=;
	b=JoXxl9yfWewOtzlKQQCh2BeItUsNVUB5rTJeJ7NGx27X0/qkc1EynU8pzYMqamBbD7Vd+T
	PbnbBoIN7YtnqpAw==
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com, Yazen Ghannam
 <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 2/5] x86/mce: Fixup APIC ID search for x86 CPER decoding
In-Reply-To: <20240624212008.663832-3-yazen.ghannam@amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-3-yazen.ghannam@amd.com>
Date: Tue, 25 Jun 2024 08:50:47 +0200
Message-ID: <87bk3p7by0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 24 2024 at 16:20, Yazen Ghannam wrote:
>  	/*
>  	 * The starting address of the register array extracted from BERT must
>  	 * match with the first expected register in the register layout of
> @@ -99,16 +103,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  
>  	mce_setup(&m);
>  
> -	m.extcpu = -1;
> -	m.socketid = -1;
> -
> -	for_each_possible_cpu(cpu) {
> -		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
> -			m.extcpu = cpu;
> -			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
> -			break;
> -		}
> -	}
> +	m.extcpu   = cpu;
> +	m.socketid = cpu_data(cpu).topo.pkg_id;

topology_physical_package_id() ?

Thanks,

        tglx

