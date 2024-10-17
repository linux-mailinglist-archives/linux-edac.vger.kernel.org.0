Return-Path: <linux-edac+bounces-2127-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7A9A244B
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88F4282A53
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C341DE2B6;
	Thu, 17 Oct 2024 13:53:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D01DD548;
	Thu, 17 Oct 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173238; cv=none; b=kUxOzjRhVXpfrsRDzSyQ33o2W/n9DBdtQ/kuvJwl+ljHe2PWvEPKsISaqKOt2ySxrSST/LxgaeNrk9Z911KGzu8QuHzpXpNULicov9Zk1s5qxoSvyqJyf+zxdJkeb2VhbAfUWdJo0JNQJQnDb+QAV7hPCc4AnafyLafDPtOHFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173238; c=relaxed/simple;
	bh=uklFFPidP+USloNpflBWOfFCND6KnGqXGXhmRyKIG0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/q/MSMv8sACKOltzjkI77rMqpVFyAjI/jZK60fqfHfNKFFW4jhJFhzTuyYt6I13l89FDeQlpjUkubK4ILIHvskWp9NCNIRy1gKrKyjUTBs83KEHVQvVyDiY3lU2rXaP70rjXq0it9r00YcfSyhGdZeZxUOer/W1p8RKzQJ9bKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F98C4CEC3;
	Thu, 17 Oct 2024 13:53:56 +0000 (UTC)
Date: Thu, 17 Oct 2024 09:54:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
 <mingo@redhat.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "john.allen@amd.com"
 <john.allen@amd.com>
Subject: Re: [PATCH v6 2/5] tracing: Add __print_dynamic_array() helper
Message-ID: <20241017095419.2c4a7943@gandalf.local.home>
In-Reply-To: <CY8PR11MB7134B1AA1F13546D2B84728089472@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
	<20241016064021.2773618-3-avadhut.naik@amd.com>
	<CY8PR11MB7134B1AA1F13546D2B84728089472@CY8PR11MB7134.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 06:58:30 +0000
"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com> wrote:

> When running the check below: 
> 
>     ${LINUX}/scripts/checkpatch.pl --strict  <this patch> 
> 
> it complains:
> 
>     CHECK: Macro argument 'el_size' may be better as '(el_size)' to avoid precedence issues
>     #36: FILE: include/trace/stages/stage3_trace_output.h:123:
>     +#define __print_dynamic_array(array, el_size)                          \
>     +       ({                                                              \
>     +               __print_array(__get_dynamic_array(array),               \
>     +                             __get_dynamic_array_len(array) / el_size, \
>     +                             el_size);                                 \
>     +       })

For once I actually agree with checkpatch in an include/trace file.

I can send another version for you.

-- Steve

