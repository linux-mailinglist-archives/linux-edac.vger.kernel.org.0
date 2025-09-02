Return-Path: <linux-edac+bounces-4716-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 959EAB40A8C
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFD57A24CA
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E947320A13;
	Tue,  2 Sep 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XO5gu2rh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F768189BB6;
	Tue,  2 Sep 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830435; cv=none; b=PHe25BjCZiiOwFdybmVtVS3dqTK50vgBS5Sq7/8dR1dACb33y9TiR0peWwydZUtEPUHSG6NcnimtdUTVGPwYTHdNHsLLOsGOiIaRuMdgLj4+w0Q0iWlyWjVemciRQvB1q8yqZXsxAHxul1mfJNaX3K9y6tibAAFWmR37yU9hpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830435; c=relaxed/simple;
	bh=K7Pny9lIg5eQlX20OS6fIAodLEVac6g7hW8/fJ1MfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZEhkMbctQjQCYEYRmjSKAdckZp+zyCJNwv8GzVZ4Gro5om864VnjgdI14QcP9MhCo8bBgJLLo6g8nhKEsd8Ym3DHqK3M46/ofWyQq197QArReYGgas3Ge8M2f1jYVUuMxNC+koHnz40luFZltCs2KUESrAeBq8+RPJgunnZDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XO5gu2rh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F20B40E01B3;
	Tue,  2 Sep 2025 16:27:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pHUka_Y3i4FE; Tue,  2 Sep 2025 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756830428; bh=F1Gxu5EpDot20ULZ+6IHr7LSES6y4Y3XB8335XIjm/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XO5gu2rhzWY8gtS1KUb8gfnvcM19XLUsN3WEJBjcGuWWtdwFTTw7C5TGWoka1MRpt
	 Gv7/aKC5aHG+bvYSHWBfxAVCkTtn9OAlno9PkXe/BWDbFAZ16LL6qVUkCkkZz8kNIq
	 rdEW+FdCDUC14BgF4dmpJv1Hzj7PWGn0Hogg4LVO2Vlm7/olMkVK42x8G2uYc8QEYf
	 p1NIWdhdePIccz0WGrp5lIxI52t2vIJ85C5oczZGx2L9YgyI/bhKutPYWxAyc0OWwn
	 Zg6J/gL8vo+N2v3mlEYe57q9HGfMIULSNuwghNbo53rnqZ51wxO2g8KhsbHVzYrhOs
	 Lr+anRn2oKWvxNHMZ7elo4fzwZBjxxznA0DYHDFbf1WDALtdLysH6vo+0/4baAlVbJ
	 Aa9aozfQQLP2KqN1pUw09N5emRFCzu7sr+Pn3rYMlFcttq2N0FU+8rr5NGyJ+1SajM
	 Lyl9TVn+1Q+1nPYvuhEHelie/uT03rwxQwfI9QA7c/QnY3vKtN9IVWaXMGzjMTC8D8
	 M76rW4JD4ZSsiC7hX8pqCtIL4bT20kBgrKZ+NLbojOQrSS2TIi+lQW5FW6oKgpvD4A
	 AjPJIRiLBArcspSzVDeSP3AQ+1pbbJVfstMBgl0+eEfThvfXEc3N/epWjYSpsVzdSP
	 DkfUhWOhnvng128gc7b5VHL8=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1387240E01B0;
	Tue,  2 Sep 2025 16:26:58 +0000 (UTC)
Date: Tue, 2 Sep 2025 18:26:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 07/20] x86/mce: Reorder __mcheck_cpu_init_generic()
 call
Message-ID: <20250902162657.GFaLca0ebBdk9j1DHO@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-7-865768a2eef8@amd.com>
 <20250901170741.GCaLXS3bUdUPksnMs8@fat_crate.local>
 <20250902133015.GA18483@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902133015.GA18483@yaz-khff2.amd.com>

On Tue, Sep 02, 2025 at 09:30:15AM -0400, Yazen Ghannam wrote:
> Moving CR4.MCE last should be okay, but deciding when to do MCG_CTL
> needs some more thought. Maybe we can have an early call for Intel and
> a late call for AMD?

I'd say move only the CR4 write and leave everything else as-is. It has worked
fine until now. Unless someone comes hands-a-waving that we need to fix it all
of a sudden...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

