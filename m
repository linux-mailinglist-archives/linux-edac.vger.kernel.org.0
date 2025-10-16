Return-Path: <linux-edac+bounces-5063-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7412CBE48CF
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D10156171A
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CEE23EA91;
	Thu, 16 Oct 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e98vpMIZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88E213254;
	Thu, 16 Oct 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631448; cv=none; b=XS5vMgzAiFrfp+QNWLzGs3VtmRr44k3hCBSeARTMtTMJU5ribBc3heBgpshheMCUavHtE6IpBRZD5Oka3aw6wifDjNEETTqbWjaakiFt/svIlR53D/J4EtIZzQQKrayKQh4RicGwqNbeJkAhFqIzfVPqMVI1PLUnAt8K2JoKaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631448; c=relaxed/simple;
	bh=ePwyMIEkVztUnbUIenuITTss9vYpW1OJ9kvTasFRqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSo+/Z8HHd1dIdnBL+m42AJv326sI2IElgUsLBWECJ88OZBq3Hh5Rk071WSCJopeCR7YC7Kh4ljlKiebI1FNwmMdQLQ2R4YA5oMQkNeMWs+rDnARvvqrLArfVaEZfe/sNfPF1k3oCNrhHrPfYnGKYQ0Y2g/d80r4aqUT0GxofOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e98vpMIZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9F9AA40E00DE;
	Thu, 16 Oct 2025 16:17:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RprFMtxObG06; Thu, 16 Oct 2025 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760631441; bh=lCvM/owjpNP9QvdrTv21SCtqHV1RNq0z0FQrUIvfdtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e98vpMIZSJkoJfCXfHZlvu/j7Xx163gPFxtLq1/7Sst7j7T8EPSc7RRsbQ8bGQ5m0
	 Hixmi63b/ur/kw2rpWvARz9v66JMiJz1KZliTYSu74CmvHyqJzqtLY3zlybnIy72os
	 Ug+2k7OT7wy4Z5FBp9Fnyb8AqmvRA+GmpJdQTIFpIesSpKggrhZfdT90v8zEqoAA9u
	 ZguWKo8UaDmHp42P5xMKMfHlsnl1wZocFJt0cixq0QBBCxRYDrnavUnFcWYTJUunY3
	 Ry566HpQq4uWoxs33XXayy4KsHnB8OEEZo4a5s0T9cUGW4pB790y9WnjWqnBxVkEtc
	 FWSss0G+bnBBN7Q8GI7a0Vk0K8K/Tbkt+K6Daw5XNlQNp5huSPjmjwInczsGdOygfR
	 sIBiP+lOnRw/23w+4rIXHB5EPOHXPkd7A5rF1UiOMRVZ1fHvapdnQ2pl41G+aswqRE
	 N8oFd9kUKtNVScWnmEi1pPW2LFAZe+CIQg7a585SPfUusoHMiJQxSaRnoxGDfssDm9
	 n2G7VuFUMCrUXcIxLtbg+bt/KV7S7sniZOuSuG1/E4UIyQZZlm7KXomyNVv5J1mMyw
	 gnaqQXeuqEvnEQ8NwZn/fq7RjVbFApYsQL6xpkUFQ6CLuutXdvWOzIMTTyNXALJnQ6
	 srZaZuatJIfLb6oG5KvmNMqw=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 342EF40E016E;
	Thu, 16 Oct 2025 16:17:11 +0000 (UTC)
Date: Thu, 16 Oct 2025 18:17:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>,
	John Allen <john.allen@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/3] ACPI: PRM: Add acpi_prm_handler_available()
Message-ID: <20251016161710.GCaPEahlw4qsCMaw4n@fat_crate.local>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
 <20251006-wip-atl-prm-v1-1-4a62967fb2b0@amd.com>
 <20251016160149.GBaPEW7ej4qvOcVfYh@fat_crate.local>
 <CAJZ5v0gvn21FeMNpJDWOZ0ZH5CZzDt0zEuXjHEpWxHjq9vHqyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gvn21FeMNpJDWOZ0ZH5CZzDt0zEuXjHEpWxHjq9vHqyw@mail.gmail.com>

On Thu, Oct 16, 2025 at 06:09:12PM +0200, Rafael J. Wysocki wrote:
> > Rafael?
> 
> I've seen it.  Are you asking for anything in particular?

LOL.

ACK/NAK?

If former, should I carry it through tip?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

