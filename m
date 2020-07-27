Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6784622ECCE
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 15:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgG0NFy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0NFw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jul 2020 09:05:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A6C061794;
        Mon, 27 Jul 2020 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BXkCKJfKaUl8bQBAmIf85h3Rs77fRZ0wJrKpqF8M6w=; b=I0bRcMk/W+M6vYFtdpE4z48P3z
        9PQoyy0wIeKKX1DrGvpc2Zz/0bJHmMqM5mKZenZPvHzKp8fAnC1z9b1X0DLIEg6mWXp94X21Bhr3V
        x+sOtr2gCVzXhM6UNaMHTnzdvUEwDhE+hlxcCdJ7XnoDVvC2qaqmuQGDHiQt9SdiMfsZfnmS7pc9e
        nuyxVqWMecoCLSP+NITU2fcB8d2ZOOKO5hPonjh81bN5o7zHBzVhOA/3frACdTom2G8+I6P90RRlt
        zFs4jkwT1hEgAYyd4Nl7XAG34yWz1jvoeuXXJ7BfS1tveWZdhdYzCe5eficAocOLHnvRpGa2CP2oB
        3PJXdHlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k02p0-0000QN-Tf; Mon, 27 Jul 2020 13:05:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88225304B6D;
        Mon, 27 Jul 2020 15:05:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B06829DBC0A0; Mon, 27 Jul 2020 15:05:36 +0200 (CEST)
Date:   Mon, 27 Jul 2020 15:05:36 +0200
From:   peterz@infradead.org
To:     hpa@zytor.com
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200727130536.GM119549@hirez.programming.kicks-ass.net>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
 <20200727083619.GF119549@hirez.programming.kicks-ass.net>
 <49251CFA-8AC3-462D-A60F-0337593BE9CD@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49251CFA-8AC3-462D-A60F-0337593BE9CD@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 27, 2020 at 05:49:28AM -0700, hpa@zytor.com wrote:
> On July 27, 2020 1:36:19 AM PDT, peterz@infradead.org wrote:
> >On Sun, Jul 26, 2020 at 10:55:15PM -0700, hpa@zytor.com wrote:
> >> For a really overenginered solution, but which might perform
> >> unnecessary poorly on existing hardware:
> >> 
> >> asm volatile("1: .byte 0xf, 0x1, 0xe8; 2:"
> >>                         _ASM_EXTABLE(1b,2b));
> >
> >Ha! cute, you take an #UD ?
> >
> >We could optimize the #UD exception handler for this I suppose, but
> >that makes it an even worse hack. The simple alternative() seems like
> >a much simpler approach.
> 
> If this is in any way performance critical, then no :) 

Yeah, I'm not sure.. the 'funny' thing is that typically call
sync_core() from an IPI anyway. And the synchronous broadcast IPI is by
far the most expensive part of that.

Something like this...

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 20e07feb4064..528e049ee1d9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -989,12 +989,13 @@ void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
 
 static void do_sync_core(void *info)
 {
-	sync_core();
+	/* IRET implies sync_core() */
 }
 
 void text_poke_sync(void)
 {
 	on_each_cpu(do_sync_core, NULL, 1);
+	sync_core();
 }
 
 struct text_poke_loc {


> Taking the #UD
> has the cute property that we end up IRET on the way back, so we don't
> even need a fix-up path.

I got that, what I had in mind was making sure #UD avoids the overhead
of doing exception entry/exit by adding an early exit.

Something like so:

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8493f55e1167..a3f41d645944 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -96,6 +96,16 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 	return *(unsigned short *)addr == INSN_UD2;
 }
 
+__always_inline int handle_serialize(struct pt_regs *regs)
+{
+	const char serialize[3] = { 0x0f, 0xe8, 0x02 };
+
+	if (regs->ip < TASK_SIZE_MAX)
+		return 0;
+
+	return !memcmp((const void *)regs->ip, serialize, 3);
+}
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -252,8 +262,13 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	 * handle it before exception entry to avoid recursive WARN
 	 * in case exception entry is the one triggering WARNs.
 	 */
-	if (!user_mode(regs) && handle_bug(regs))
-		return;
+	if (!user_mode(regs)) {
+		if (handle_bug(regs))
+			return;
+
+		if (handle_serialize(regs))
+			return;
+	}
 
 	state = idtentry_enter(regs);
 	instrumentation_begin();
