Return-Path: <linux-edac+bounces-2852-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC48A075CB
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 13:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6127216575A
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03076216E20;
	Thu,  9 Jan 2025 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OBJrs7n9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007E1E515;
	Thu,  9 Jan 2025 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426045; cv=none; b=tUMVpOB4F9xgcsvO9P9F7HtSJJFYQY4hWkpKsuAatrM1w/t7EMDh/B788S21jKMVRj+RTGNKc0AN6SMfaBave5zQI0+hjMzTLBZRNLIs0bFCQQa19RiEMO8pE+2NmrcO8UbM3SwZTrvFhxC7stMvAIxJCkkCUQWaJVYBv+Y/fJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426045; c=relaxed/simple;
	bh=xajCbxem9WYTMXB1kHiUq/UzVh8YqRTitWTuRymRiio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2uNzYAXJbPcurC/2QZd1qFl0E2+VXOuERIEz7k8xg/LTbOGG1Q8uN7m4Yl506MoOnLpsqnZ68ERynWOklMjLO2gitgRPQVe2mH8RsMwvDVyaKgzTc0cVOm+cqj5tL12ztiJfaA7hlHK7eT7RRUAper5Omc6IxgqA0zR0x3wpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OBJrs7n9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE42B40E02C0;
	Thu,  9 Jan 2025 12:33:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id axfxdHjtJrxR; Thu,  9 Jan 2025 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736426036; bh=zC24gEoKY7o0cyYHKnhih9i9LV/2PfvFg5/BIbGabCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBJrs7n9ekrVigZkybghYD28bUH42H5g1FA+vX3ZrmFuSpTFThRHkjwfq5Zmoo68K
	 m3aGQkw2vQ7lo5204ZF0LzhnYFOE8FG5fSMLnyNHHe7depL8X766cz5d6ryxgRoNTH
	 ouTjmPMkJ/fdZ0sAaB6CS0E8X8UPPhtSQnRDdDfCN1+Lcl4we+I3nA9F9joLWNG7B8
	 spXGrZNZaTZErRkSzOkrBR7fYYeH8O9i/n0YoevuI+osdljP/oDHBPvk5XxzoEISRo
	 wQoFKg4NAkUiVatLCW6X77ISKCiDYdgTDmeZ2i8JZgTFlGB1K/AVJ+0uZ55nkz7e76
	 4h9Fwimx9lrUsSrD2m0pC6a3qaYJFUrMhJlhPeTR7UCe4DH2KKRaOVLqlacr6E5IWe
	 QUPtPqOxX/lzIAOP1tIDwuAWdXXjz1xyOM1sLim7g2SQkOR5xDFQ0qMOuiG/nZdXLj
	 KVDIph65vu5rFtQ6hI4psno8IAqfCSSmYG55P/XiOeHqE2/uz4g6WfaZ2VrZ4hByE5
	 +0kQo9EFxTJ6pA+U8Y8+jlRxscPxNmX2MLkCIOvwXwH+sawqW/h1VNMZjZleXHasDN
	 M+uiu8ON/hu5qIi3xL7ryFHJR1AMAUEa37rr5yR5oTP+aI1aH8LxDkkuSO+c/xqWfm
	 jg3eU85kZxRE9VKafXEJfz9Q=
Received: from zn.tnic (p200300ea971F933C329c23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:933c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E0B940E028B;
	Thu,  9 Jan 2025 12:33:12 +0000 (UTC)
Date: Thu, 9 Jan 2025 13:32:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-5-shiju.jose@huawei.com>
 <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
 <3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>

On Thu, Jan 09, 2025 at 11:00:43AM +0000, Shiju Jose wrote:
> The min_ and max_ attributes of the control attributes are added  for your
> feedback on V15 to expose supported ranges of these control attributes to the user, 
> in the following links.  

Sure, but you can make that differently:

cat /sys/bus/edac/devices/<dev-name>/mem_repairX/bank
[x:y]

which is the allowed range.

echo ... 

then writes in the bank.

> ... so we would propose we do not add max_ and min_ for now and see how the
> use cases evolve.

Yes, you should apply that same methodology to the rest of the new features
you're adding: only add functionality for the stuff that is actually being
used now. You can always extend it later.

Changing an already user-visible API is a whole different story and a lot lot
harder, even impossible.

So I'd suggest you prune the EDAC patches from all the hypothetical usage and
then send only what remains so that I can try to queue them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

