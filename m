Return-Path: <linux-edac+bounces-3654-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4CA97385
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282063B9D23
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41587292906;
	Tue, 22 Apr 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h3sx9OB+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BEC1DFE8
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342519; cv=none; b=Qr6X7pNUthjBh9teb/dnIKr9KhWDU6S9uDTMOZKSL1NsziQav8SRtNIAFwL58DUhdnWoK24VHiHa/adQ1V0PNUrtWJceWtvLN0AEWJqR+AAS5rBt7gFW3FdN6IiXfQ6QeySJ96ZNzt9SUxy0A/HgmND1D9iWMWNcWVaJ3W9D1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342519; c=relaxed/simple;
	bh=9iavKkacn4iffYOZIqROb6UXRi+/ZgUrG1HggnTnmqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WACg8OT1EItz35u3NjQ4HxASZ9JFqbd8AR7v7ElJ3FqpKp79QPmBeOWxvIrlu7AmkB1JWsATEMEEnfno7REXYfvA5/u4KBR5UXjeg/+dIhqCs+LYdY57GUvsrXB2emA0GOWYlGDlpNI6BsnEDYp/2Z3hHFdrvl9qrhjWIUaWSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h3sx9OB+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F0FA240E01F6;
	Tue, 22 Apr 2025 17:21:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wTqp-ikYh9TO; Tue, 22 Apr 2025 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745342509; bh=uE5REXsoTlE9qQbwyMMzqMZpXIxc5pM5zdVhXCD1qGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3sx9OB+Nn0QzoLRQfj9h9Q411dC5QJntEvEOxkjjxMBQ3VMCdDF2U/JU9abckCza
	 3uVLFWUc+nGL7dGFcV/XNCDb3NvxItJGiP0FSJA7OP+qpfsOx8KMh74fu/vxY+Lgna
	 xl1kzDZObVkM04Q7HiwXHhgf8dfSGvRWxbf4x7zhyQhBkOjE6EJmDu/LIQO81KQyhF
	 C/i5E3naOplaDTxmDhmcJ6n2T7YhYJDGlhwMl92njcm7G515m/ssd7b8Du1H4QfcrW
	 VCSPsJ9gv7aWq3VmENBABG9JcsvHeL1nQuMMquKVr90gEZq8m8a9heXVI4XTTVRg4M
	 hlJWpMkPXlIMmDrHukCgAg2+Rf8oUE0irA9Z+tFj6ebK26JFDWvyrByS+G7+n1k7a9
	 uU0q/M1PzIcxDPs2ag0bNfM+A2QEHh6gsVAVUNa6otvOzSoWBt4ZnR0KJCFYPXKpM4
	 QcmUF8/WTm90+6biexly9ORQIA+UBnOh/U99/RGUZFq/kp8NhY0a3LEp1+j6SBs2S8
	 MrdkF+tz+NwTuTwXhy8FH2bWBomBfxE5uAdDP8cO4v5EbgUEAKksay4ZhJzRrKTud0
	 7SR1Siups41eFrGThQq/FzZ1Eb7dLOYaATfZtgcokuGrlzhQeOe/LPVT8gEjqwr8nH
	 38tVnm3C0mSQPtoadPL513pE=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 635F740E01DA;
	Tue, 22 Apr 2025 17:21:44 +0000 (UTC)
Date: Tue, 22 Apr 2025 19:22:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rama devi Veggalam <rama.devi.veggalam@amd.com>
Cc: linux-edac@vger.kernel.org, git-dev@amd.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com
Subject: Re: [PATCH 6/6] MAINTAINERS: Add maintainers fragment for XILSEM
Message-ID: <20250422172245.GBaAfQZVUbYWJQHDQu@renoirsky.local>
References: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
 <20250422162347.3217007-7-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422162347.3217007-7-rama.devi.veggalam@amd.com>

On Tue, Apr 22, 2025 at 09:53:47PM +0530, Rama devi Veggalam wrote:
> +XILINX VERSAL XILSEM EDAC DRIVER
> +M:	Rama Devi Veggalam <rama.devi.veggalam@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
> +F:	drivers/edac/xilinx_xilsem_edac.
					something ate the 'c' at the
					end.

If you add yourself as a maintainer, I'd need you to review patches,
respond to other people on the mailing list and generally not disappear.

And because I have never worked with you before, I'd suggest you make
yourself a reviewer in the beginning and we'll see how it all goes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

