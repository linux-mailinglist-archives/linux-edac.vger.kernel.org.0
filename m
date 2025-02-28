Return-Path: <linux-edac+bounces-3233-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8FA49850
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905BB3B8475
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5742620C3;
	Fri, 28 Feb 2025 11:29:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D349849C;
	Fri, 28 Feb 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742159; cv=none; b=BZ1HhiavlT7RxIYxxeZv2ghBN5mZgUs+37Qbb9ycovZzi45s5H1P3P98jIWfmox36Nl7xTNUV3QsQXALiQYi4Z4RLrEr6NHxCNmnEjSm/sjlcHE4dV+Y1Fhr9X6Xt1FaYOO1C2RsW/Cz3inUz5vNYUerwPEk/K4VegJidmNYGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742159; c=relaxed/simple;
	bh=t2rsTXukOG1wdsDx/CDpSDoU0C2ghthM/Wky2Fb/gdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvFX7LgtIWuoaI062oLJ+dOFUdSYy7Tnh50oJDhDIeHfs6O2ckdycNMei8+r0E7WyrJY7rLl/oddrYJGQVKLktGJ4dqyJceqPMdM78oHh3m9WrYRdGFYAmDlmdTvws96W3t+/ccE4ZjBcMbtKcbOj28j/hZ+FxnmbDQMQDOr9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B84C4CED6;
	Fri, 28 Feb 2025 11:29:11 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:29:08 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
	robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
	rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
	wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	tongtiangen@huawei.com, gregkh@linuxfoundation.org, will@kernel.org,
	jarkko@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@linux.alibaba.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com
Subject: Re: [PATCH v18 2/3] mm: memory-failure: move return value
 documentation to function declaration
Message-ID: <Z8GeBJ9tTayTm9s9@arm.com>
References: <20250107081735.16159-1-xueshuai@linux.alibaba.com>
 <20250107081735.16159-3-xueshuai@linux.alibaba.com>
 <Z8BbFRupgknBTvH8@arm.com>
 <0c93542f-4521-41bc-a030-5b2d8621aa6a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c93542f-4521-41bc-a030-5b2d8621aa6a@linux.alibaba.com>

On Fri, Feb 28, 2025 at 09:46:30AM +0800, Shuai Xue wrote:
[...]
> > On Tue, Jan 07, 2025 at 04:17:34PM +0800, Shuai Xue wrote:
> > > Part of return value comments for memory_failure() were originally
> > > documented at the call site. Move those comments to the function
> > > declaration to improve code readability and to provide developers with
[...]
> By the way, could arm maintainers help to ack patch 1 and 3 if there
> is no objection?

James Morse is listed as reviewer of the ACPI APEI code but he's busy
with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
maintainers, hopefully they can help. Here's the full series:

https://lore.kernel.org/r/20250107081735.16159-1-xueshuai@linux.alibaba.com/

-- 
Catalin

