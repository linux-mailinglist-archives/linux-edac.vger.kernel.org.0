Return-Path: <linux-edac+bounces-3539-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC90A88B6E
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927B71898C59
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C928E5FC;
	Mon, 14 Apr 2025 18:33:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A5128E5F3;
	Mon, 14 Apr 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655636; cv=none; b=KrQk/lkrao0xaurwVr6kLB1oZBrPzX9zdvwdg7D2F0Ob7en+hMmhhxnU/LUVmZWhHLAtMi6vy0CSVO0E5EFxVTtoBL/NZtiFfsw9NSCOTuD2Tgzf+pFKc+iwomBZVwIgDBeVWXYrjSF9P3X1uZXlk6cdJVKB5AKzU3A6b28J3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655636; c=relaxed/simple;
	bh=sVjBGy6SOCEGGJCLb83pBmzyg+Yi/NclO083HUIIt0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulDqdptnXrcZgbN3S9B5R1iRdw7+HsKioRZokqeKNXeLDt9RuOf/4Y8BGSHp9wY1lQdZ5C8o66/lrkSMhCZ9EOB71Be7NxoisBmc/5n9vFZM1wpYS47WgtdjHl9acDddtzXN2z6djafMuSlWYsQ2/wJBfua+JNtDNv76LqCA4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB40AC4CEE2;
	Mon, 14 Apr 2025 18:33:54 +0000 (UTC)
Date: Mon, 14 Apr 2025 14:35:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, Tony
 Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2] trace, RAS: Use __print_symbolic helper for entry
 severity for aer_events
Message-ID: <20250414143526.4ab44b28@gandalf.local.home>
In-Reply-To: <20250414163347.GEZ_0461mT0OZGpOjl@fat_crate.local>
References: <20250414153835.947207-1-sargun@sargun.me>
	<20250414163347.GEZ_0461mT0OZGpOjl@fat_crate.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 18:33:47 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Apr 14, 2025 at 08:38:34AM -0700, Sargun Dhillon wrote:
> > The chained ternary conditional operator in the perf event format for
> > ras:aer_event was causing a misrepresentation of the severity of the event
> > when used with "perf script". Rather than building our own hand-rolled
> > formatting, just use the __print_symbolic helper to format it.
> > 
> > Specifically, all corrected errors were being formatted as non-fatal,
> > uncorrected errors, as shown below with the BAD_TLP errors, which is
> > correctable. This is due to a bug in libtraceevent, where chained
> > ternary conditions are not parsed correctly.  
> 
> So because *some* libtraceevent has a bug, we're wagging the dog, not the
> tail?

Agreed.

If something isn't parsed correctly in libtraceevent, please let me know!

Can you apply this to libtraceevent and see if it fixes your issue:

diff --git a/src/event-parse.c b/src/event-parse.c
index 6317ff6..4a09fcc 100644
--- a/src/event-parse.c
+++ b/src/event-parse.c
@@ -2083,6 +2083,16 @@ process_cond(struct tep_event *event, struct tep_print_arg *top, char **tok)
 
 	type = process_arg(event, right, &token);
 
+ againagain:
+	if (type == TEP_EVENT_ERROR)
+		goto out_free;
+
+	/* Handle other operations in the results */
+	if (type == TEP_EVENT_OP) {
+		type = process_op(event, right, &token);
+		goto againagain;
+	}
+
 	top->op.right = arg;
 
 	*tok = token;

I'm getting ready to post a new version of libtraceevent, and if this fixes
the parsing then I'll include this too.

-- Steve

