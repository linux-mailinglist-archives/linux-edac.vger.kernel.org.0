Return-Path: <linux-edac+bounces-2899-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14AA10893
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 15:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA92F18823CC
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99E13AD3F;
	Tue, 14 Jan 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeNvKW0l"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F31369AA;
	Tue, 14 Jan 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863599; cv=none; b=KyFgR+WtgquaBx+7cSYbHxhYleARCerOV/9aVMnJXqzvFkVYecGN2lZHzxOSaH4QBrrj2QIcNdAJTmx2qxShhdObDd4Fx+JG4YN+YGp2hjSshuwzdMqgqn00plxZSZ7Fmmh9Cvtbu25NXA1YhIiWhSxXspNb6wbeSLevPXMBFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863599; c=relaxed/simple;
	bh=22mONV1hQ6FNPcsvXydlp444mm0Si+QkC50VtPd7T60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8ZdJvltmTzbrHkTEdfSlytoQXSxoqr1yjPTzSgB+/x6dkL04rLdCQnYRjxWTCAITrU+uLH0iZhAdxQxBnQC3nK+vi9g85NTboln1H+F4kooXzBr2VQzwjyUG58WuFzlEvyVsFPZMyhfODYUE1sBw6SjhUOZx4j9qG4K3LE+UqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeNvKW0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C91C4CEDD;
	Tue, 14 Jan 2025 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736863599;
	bh=22mONV1hQ6FNPcsvXydlp444mm0Si+QkC50VtPd7T60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UeNvKW0lMWyBwHMfjsDG7+/QmujYta/tfHMQvu4RHTe4e9NT6AaQuDCPiqol8viyU
	 aHzvgLxqfl0IivFQGxYl51T27skt9Z6mRiEF2qsWAb/da+kZYCPqsNNeqpZ9vHakag
	 YEgKXLKghivGc9eL9zG9gz+tW5aZnt5C+DTuW39ZjpNog/O3hNb8E5dyyF5V13nts7
	 4FiuWCdGD4hDYo3Yk0TlkYdRM414HlFH3F1voILDWNgs1yQ8dNeidKTvPYo5++D0v/
	 62mdVOFGYAOtLmyETG6JSdYX37WjdVgKbkGPp7uVlss44zfLHQ4iceh+kpgo5USoFK
	 2O0bUqc7W2vXQ==
Date: Tue, 14 Jan 2025 15:06:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <vishal.l.verma@intel.com>, <shiju.jose@huawei.com>,
 <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
 <dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
 <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
 <rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
 <dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
 <james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
 <erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
 <gthelen@google.com>, <wschwartz@amperecomputing.com>,
 <dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
 <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
 <roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
 <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20250114150546.0a769a8f@foz.lan>
In-Reply-To: <20250113153639.00003dfa@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250113154634.4e831d66@foz.lan>
	<20250113153639.00003dfa@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 13 Jan 2025 15:36:39 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> > >    
> > > 5. CXL features driver supporting ECS control feature.
> > > 6. ACPI RAS2 driver adds OS interface for RAS2 communication through
> > >    PCC mailbox and extracts ACPI RAS2 feature table (RAS2) and
> > >    create platform device for the RAS memory features, which binds
> > >    to the memory ACPI RAS2 driver.
> > > 7. Memory ACPI RAS2 driver gets the PCC subspace for communicating
> > >    with the ACPI compliant platform supports ACPI RAS2. Add callback
> > >    functions and registers with EDAC device to support user to
> > >    control the HW patrol scrubbers exposed to the kernel via the
> > >    ACPI RAS2 table.
> > > 8. Support for CXL maintenance mailbox command, which is used by
> > >    CXL device memory repair feature.   
> > > 9. CXL features driver supporting PPR control feature.
> > > 10. CXL features driver supporting memory sparing control feature.
> > >     Note: There are other PPR, memory sparing drivers to come.    
> > 
> > The text above should be inside Documentation, and not on patch 0.
> > 
> > A big description like that makes hard to review this series. It is
> > also easier to review the text after having it parsed by kernel doc
> > build specially for summary tables like the "Comparison of scrubbing 
> > features", which deserves ReST links processed by Sphinx to the 
> > corresponding definitions of the terms that are be compared there.  
> 
> Whilst I fully agree that having a huge cover letter makes for a burden
> for any reviewer coming to the series, this is here at specific request
> of reviewers. 

Ok, then. Yet, even for them it would be very hard to track what
changes from v19 to the next versions if you change something at 
patch 00.

> We can look at keeping more of it in documentation though
> it's a bit white paper like in comparison with what I'd normally expect
> to see in kernel documentation.

Personally, I like comprehensive documentation at the Kernel.

> >   
> > > Open Questions based on feedbacks from the community:
> > > 1. Leo: Standardize unit for scrub rate, for example ACPI RAS2 does not define
> > >    unit for the scrub rate. RAS2 clarification needed.     
> > 
> > I noticed the same when reviewing a patch series for rasdaemon. Ideally,
> > ACPI requires an errata defining what units are expected for scrub rate.  
> 
> There is a code first ACPI ECN that indeed adds units.  That is accepted
> for next ACPI specification release.
> 
> Seems the tianocore bugzilla is unhelpfully down for a migration
> but it should be id 1013 at bugzilla.tianocore.com
> 
> That adds a detailed description of what the scrub rate settings mean but
> we may well still have older platforms where the scaling is arbitrary.
> The units defined are sufficient to map to whatever presentation we like.
>
> > While ACPI doesn't define it, better to not add support for it - or be
> > conservative using a low granularity for it (like using minutes instead 
> > of hours).  
> 
> I don't mind changing this, though for systems we are aware of default scrub
> is typically once or twice in 24 hours.

Yes, I noticed that we're using seconds after reading other patches.
It sounds OK to me to keep it as-is. 

It is really unlikely that we would ever have scrubbing finishing in less
than a second.

Thanks,
Mauro

