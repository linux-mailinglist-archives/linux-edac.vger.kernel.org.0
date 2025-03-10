Return-Path: <linux-edac+bounces-3343-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06136A5A4F6
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 21:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB26B3A636A
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907571DE899;
	Mon, 10 Mar 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJ1fYbVK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21CEC5;
	Mon, 10 Mar 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638519; cv=none; b=kssGcObmDWt3uEWBRhH2lbiGsy8VRCCCFM7IEF6ZqLx9oym9EZ3vQgoKZiYh641dywnbXru4DBdQqpdAwQz29FsbWlpI+7ovliZiI+GH5RtUuuqrgFew6f7dE1Mae7esrEA9yueLTZk0kSkntgEtN76dWdhHrgxGyKkyzfI9HOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638519; c=relaxed/simple;
	bh=HSsMnI4cC6mW97nelx12+H+5tkQ+KC89ClBZc2VpfjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFXT/Xo/V0gr+UFNAjBg+8TYWLVsKvcyOuALKUJEAlpdTBl7aq0fWDrg3eOZCQeU2iPxgY9mQ3iZrnWVVL8qy9H7GWFgsrUp6AxZlb4j7pH2ML1YKJX3FS1i2R12o+oprCtMQvJPKYd80atGNXgVXt2Fnx3q0wD/Y8Dy3Wim5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJ1fYbVK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741638518; x=1773174518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSsMnI4cC6mW97nelx12+H+5tkQ+KC89ClBZc2VpfjA=;
  b=gJ1fYbVKWx7lk0+nRyTGH7QX6MRmLfgh05FgPvlU5RupZrpwIlGgRlnC
   crlG1rozB1Wq0W1rKnV4DLA1YgxlQNIGVBnHXqvV8LSMUJeQxUQC/jQZb
   YMVa4OhSGw+WBh6k+DmwoM0ulkOV0gN4bSoWOcLYP61uJfwejdIqrRMvv
   JA7iDSiNkyHIcFGoCYZBypZ0aL4VeOLF0bDKYjP6dZVGmwD6z58NZn8vm
   j/e3X4DdrfB6ocYeFhGlg3wRGnGOvzqK6ah19x0d4ZnYzzD2RgnYU1qIZ
   PVbujRyN8mW1K6e4u7A3iqYS4rs2uc/6ibREyQg0bH0NU6FbTBrNgnAxL
   g==;
X-CSE-ConnectionGUID: wtHPDtytSxWeDYHRw3tXcw==
X-CSE-MsgGUID: jE2CWlK9RVKwojzh7Kdujg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53281775"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="53281775"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 13:28:36 -0700
X-CSE-ConnectionGUID: Io1LQZW1SMCWx8jlCrJC6w==
X-CSE-MsgGUID: TkRSYNbZTDiqa6hIOx+iIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="157305575"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 13:28:35 -0700
Date: Mon, 10 Mar 2025 13:28:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
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
Subject: Re: [PATCH 1/8] cxl: Add helper function to retrieve a feature entry
Message-ID: <Z89LcUIWO9m8Vtru@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-2-shiju.jose@huawei.com>
 <Z8tGz33l9vDzuJLy@aschofie-mobl2.lan>
 <e8e33d46aa1b478db601de29e047cb5f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e33d46aa1b478db601de29e047cb5f@huawei.com>

On Mon, Mar 10, 2025 at 06:15:38PM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Alison Schofield <alison.schofield@intel.com>
> >Sent: 07 March 2025 19:20
> >To: Shiju Jose <shiju.jose@huawei.com>
> [...]
> >> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
> >> +					     const uuid_t *feat_uuid)
> >> +{
> >> +	struct cxl_features_state *cxlfs = to_cxlfs(cxlds);
> >> +	struct cxl_feat_entry *feat_entry;
> >> +	int count;
> >> +
> >> +	/*
> >> +	 * Retrieve the feature entry from the supported features list,
> >> +	 * if the feature is supported.
> >> +	 */
> >> +	feat_entry = cxlfs->entries->ent;
> >
> >Do we need some NULL checking here on cxlfs, entries
> 
> Hi Alison,
> 
> Thanks for the feedbacks.
> We had check on cxlfs before
> https://lore.kernel.org/all/20250122235159.2716036-5-dave.jiang@intel.com/
> but removed because of the following comment.
> https://lore.kernel.org/all/20250124150150.GZ5556@nvidia.com/

Hi Shiju,

I have not followed all along, so yeah my questions may be a bit pesky
at this point. I did see the comment linked above about how the driver
must be bound at this point. I think my question is a bit different.

Are each of these guaranteed not to be NULL here:

to_cxlfs(cxlds)
cxlfs->entries
cxlfs->entries->ent

If these cannot be NULL, then all good.

--Alison



> >
> >
> >> +	for (count = 0; count < cxlfs->entries->num_features; count++,
> >> +feat_entry++) {
> >
> >Was num_features previously validated?
> Not in the caller. Had check for num_features here before in cxl_get_feature_entry()
> as seen in the above link.
> >
> >> +		if (uuid_equal(&feat_entry->uuid, feat_uuid))
> >> +			return feat_entry;
> >> +	}
> >> +
> >> +	return ERR_PTR(-ENOENT);
> >
> >Why not just return NULL?
> Will do.
> >
> >
> >> +}
> >> +
> >>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >>  		       enum cxl_get_feat_selection selection,
> >>  		       void *feat_out, size_t feat_out_size, u16 offset,
> >> --
> >> 2.43.0
> >>
> 
> Thanks,
> Shiju
> 

