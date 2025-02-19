Return-Path: <linux-edac+bounces-3164-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2820EA3C7D4
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CBE3ABF46
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404551F419D;
	Wed, 19 Feb 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cPd+ngRt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB61E4AB;
	Wed, 19 Feb 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990796; cv=none; b=cmONimr6HxvbOSlFGdTS6KL1QMV7vWrgwRLRxlFMM6fDYCQ51m84qN8GejOuNkJpQtvzHf4l5j5Ib6gQYMWL/e3xz6/5IGWWmy/DUCv1rhjpu4wX6qO1CfkxoEy5wwMMtTubZ4nuohI+KYnt6kimM0oLyJjHjcHF8VvfUIYDZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990796; c=relaxed/simple;
	bh=KFAhhr4xy5oMN9P+b2/vDe/6EZSVQHCstfpynxzGvo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKItkRl+r58K6QUUFtcZNNK1ECmy4mkJmRVXAvQPAeHD4Hf3HFPdcQWY5QqwXV/cwQydB/AJQSokT9Dzw/m/BXDMU/J6M5mtpYi//Ee5MDJ0vBTKFsKbdTdk5ovy5EWPv9e4qTl0SIqp/Z034bSGOBSL20ljR79tCFpDLqRhXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cPd+ngRt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E10C40E0176;
	Wed, 19 Feb 2025 18:46:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z15dtccO68ao; Wed, 19 Feb 2025 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739990786; bh=vgFdYNMT39E8eGj67uvR/82qw40Mmbyr9Z4EvKWNqPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPd+ngRtOjokmWFhMpHZLwUzUlKHAvYG8bszufBHMcN0PPdJMFf/RCGmK8x2Zw4MA
	 5oTCrc4aHfXcrYrYvHJmy2MkGuopszfBHuIHl2ZZyiCQmWyYTFWcKqzS1Jlcs9yzl1
	 f1AL69xikS7OBVc0n1mua16IV8AStAb12McccNjCUy2JaQbx5Q5GoJfnpkauZepxJE
	 cvfb58aqFPCTGhzDaows5bOf99k3CATYZ3+ZW4p2VEK80hkLPNfBiD/HRcl7LcqizD
	 vHkzq7EHabgyXkHf/BxCd5bBwPbC1jaIMJrhDcid8Y9sWR+/pXRoOTNnB+ABNW6c0Y
	 wWYad2LQneyEntYR3fs1F5vp7i0l9zFcEybwTLYGbBRvpr7IY+iDSCJA4JHnja+226
	 vCnUvz47JApOTYss0qfKLpwCqZOuyLfN3fhMnkivEQeg+h+Hyur2Bcxa5vHtRoCFkE
	 o61n1Pk7f+xdjYlnwFJkRyBJNEM0ytz77Ik5WJlW1HF4wgz8N+Qmd+f8OWox4t420d
	 MfbsJ6hV83SYxA5JGAjP2+AtQxCuK2ToJ2cEmj33SDYDG1x/dNoJplZ2Ruq5hJhVPy
	 AIbtWv+YzQZ2MCA9cXE50rKgsBHNebZ6vTBGmBHjBYLWlbkl2+GyINsr4p63Vxg8RT
	 d4y3gDw8sr/JyvvO8YDBCWaE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4A6740E015D;
	Wed, 19 Feb 2025 18:45:40 +0000 (UTC)
Date: Wed, 19 Feb 2025 19:45:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
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
	Linuxarm <linuxarm@huawei.com>, Vandana Salve <vsalve@micron.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250219184533.GCZ7YmzTDk5B4p-C7e@fat_crate.local>
References: <20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
 <20250109183448.000059ec@huawei.com>
 <20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
 <20250113110740.00003a7c@huawei.com>
 <20250121161653.GAZ4_IdYDQ9_-QoEvn@fat_crate.local>
 <20250121181632.0000637c@huawei.com>
 <20250122190917.GDZ5FCXetp9--djyQ6@fat_crate.local>
 <20250206133949.00006dd6@huawei.com>
 <20250217132322.GCZ7M4Somf2VYvbwHb@fat_crate.local>
 <20250218165125.00007065@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218165125.00007065@huawei.com>

On Tue, Feb 18, 2025 at 04:51:25PM +0000, Jonathan Cameron wrote:
> As a side note, if you are in the situation where the device can do
> memory repair without any disruption of memory access then my
> assumption is in the case where the device would set the maintenance
> needed + where it is considering soft repair (so no long term cost
> to a wrong decision) then the device would probably just do it
> autonomously and at most we might get a notification.

And this is basically what I'm trying to hint at: if you can do recovery
action without userspace involvement, then please, by all means. There's no
need to noodle information back'n'forth through user if the kernel or the
device itself even, can handle it on its own.

More involved stuff should obviously rely on userspace to do more involved
"pondering."

> So I think that if we see this there will be some disruption.
> Latency spikes for soft repair or we are looking at hard repair.
> In that case we'd need policy on whether to repair at all.
> In general the rasdaemon handling in that series is intentionally
> simplistic. Real solutions will take time to refine but they
> don't need changes to the kernel interface, just when to poke it.

I hope so.

> The error record comes out as a trace point. Is there any precedence for
> injecting those back into the kernel? 

I'm just questioning the whole interface and its usability. Not saying it
doesn't make sense - we're simply weighing all options here.

> That policy question is a long term one but I can suggest 'possible' policies
> that might help motivate the discussion
>
> 1. Repair may be very disruptive to memory latency. Delay until a maintenance
>    window when latency spike is accepted by the customer until then rely on
>    maintenance needed still representing a relatively low chance of failure.

So during the maintenance window, the operator is supposed to do

rasdaemon --start-expensive-repair-operations

?

> 2. Hard repair uses known limited resources - e.g. those are known to match up
>    to a particular number of rows in each module. That is not discoverable under
>    the CXL spec so would have to come from another source of metadata.
>    Apply some sort of fall off function so that we repair only the very worst
>    cases as we run out. Alternative is always soft offline the memory in the OS,
>    aim is to reduce chance of having to do that a somewhat optimal fashion.
>    I'm not sure on the appropriate stats, maybe assume a given granual failure
>    rate follows a Poison distribution and attempt to estimate lambda?  Would
>    need an expert in appropriate failure modes or a lot of data to define
>    this!

I have no clue what you're saying here. :-)

> It is the simplest interface that we have come up with so far. I'm fully open
> to alternatives that provide a clean way to get this data back into the
> kernel and play well with existing logging tooling (e.g. rasdaemon)
> 
> Some things we could do,
> * Store binary of trace event and reinject. As above + we would have to be
>   very careful that any changes to the event are made with knowledge that
>   we need to handle this path.  Little or now marshaling / formatting code
>   in userspace, but new logging infrastructure needed + a chardev /ioctl
>   to inject the data and a bit of userspace glue to talk to it.
> * Reinject a binary representation we define, via an ioctl on some
>   chardev we create for the purpose.  Userspace code has to take
>   key value pairs and process them into this form.  So similar amount
>   of marshaling code to what we have for sysfs.
> * Or what we currently propose, write set of key value pairs to a simple
>   (though multifile) sysfs interface. As you've noted marshaling is needed.

... and the advantage of having such a sysfs interface: it is human readable
and usable vs having to use a tool to create a binary blob in a certain
format...

Ok, then. Let's give that API a try... I guess I need to pick up the EDAC
patches from here:

https://lore.kernel.org/r/20250212143654.1893-1-shiju.jose@huawei.com

If so, there's an EDAC patch 14 which is not together with the first 4. And
I was thinking of taking the first 4 or 5 and then giving other folks an
immutable branch in the EDAC tree which they can use to base the CXL stuff on
top.

What's up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

