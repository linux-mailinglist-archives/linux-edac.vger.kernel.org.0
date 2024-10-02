Return-Path: <linux-edac+bounces-1958-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE998E0A1
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0171F26D08
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82A1D0E1F;
	Wed,  2 Oct 2024 16:28:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A478567D;
	Wed,  2 Oct 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886494; cv=none; b=Y+nyB36w7Nn1JH2iHCFjJCnKz4lHhh3ArkdCtaNNox0A44UKtFA9vOd3aPVzfRClBMzKUaC2N8tpiZ6QTVQAOPCBPRwS2hP0Pg9yvQPcnyn9U4zMwjpX/Tv4GfKXltb2d3vqGQJjxnX/K+37JfF3hcPqyPZpCx+d6EQkL8AHBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886494; c=relaxed/simple;
	bh=2dcmbw3kfFyHsiVGMk/IB9rEa1pe092rMXmmmmqod6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvte0xMQ71bQPhCyTVBM049xnxMNxbxpscdZ30rYhIw7ZUL0eExOzjrWvd9GOiwr8AoH9dTUirLxS3v89HBIP48BZVKn3YmhARmj0W0YD4Fnl6oIutXIc7nBORGD//eAMtOBUhk0qRFF3mkHDh9x6+F8khxQt87qWx8UNCnIn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBDDC4CEC2;
	Wed,  2 Oct 2024 16:28:11 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:29:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <lenb@kernel.org>, <mchehab@kernel.org>, <james.morse@arm.com>,
 <airlied@gmail.com>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
 <avadnaik@amd.com>
Subject: Re: [PATCH v5 2/5] tracing: Add __print_dynamic_array() helper
Message-ID: <20241002122903.24e591bd@gandalf.local.home>
In-Reply-To: <20241002110641.3575c632@gandalf.local.home>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
	<20241001181617.604573-3-avadhut.naik@amd.com>
	<20241002110641.3575c632@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 11:06:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm currently adding code where I need this patch too ;-)
> 
> I can make a branch that only has this patch based off of v6.12-rc1 where
> we can both use it. Can we do that?

I take this back. I'm doing something a little different (updating ftrace
specific events, which has their own macros).

Feel free to keep using it and pulling it into your tree.

-- Steve

