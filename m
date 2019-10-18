Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA1DBE25
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442062AbfJRHRQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 03:17:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393754AbfJRHRP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Oct 2019 03:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xuZcX50gowMnHCXslxu8/ipZgjeVhaLN18/D4w4N5wU=; b=f05s2Bg7TIJg9Y9H5oM+k8ukS
        zsIcNdysTZZjx/N3wyHX/I6pMmRISkjKXyRFz48/vBmVEn6r8UwhxEHPQIk3SaF0TJdnRxxz+Pc75
        AzgVslS30ZEqsYYwS3elgGuWPJcK2DG664tetIFLGrW5MhQT5bjuHJpgZIU9jB071cGLzKVxp6DSR
        W88ePZJzBK9DKxOUUtgSFk6fHP+eCMxNDDKBI5w2UHPQj+Dd6ynO/12I+dzwci4mczldbqSUV3RWa
        matYqQq7m9AIEzdWagzRRLHuwRBcIcVVM20o7e+/1GOJwo4+T1ejJPdpsP2uHl/tP/7Ultb+KPzuJ
        ildaua8Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLMVZ-0007GQ-LD; Fri, 18 Oct 2019 07:17:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B38FC301124;
        Fri, 18 Oct 2019 09:16:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 645062B17E63A; Fri, 18 Oct 2019 09:17:07 +0200 (CEST)
Date:   Fri, 18 Oct 2019 09:17:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191018071707.GA2328@hirez.programming.kicks-ass.net>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017214445.GG14441@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 17, 2019 at 11:44:45PM +0200, Borislav Petkov wrote:
> On Thu, Oct 17, 2019 at 09:31:30PM +0000, Luck, Tony wrote:
> > That sounds like the right short term action.
> > 
> > Depending on what we end up with from Srinivas ... we may want
> > to reconsider the severity.  The basic premise of Srinivas' patch
> > is to avoid printing anything for short excursions above temperature
> > threshold. But the effect of that is that when we find the core/package
> > staying above temperature for an extended period of time, we are
> > in a serious situation where some action may be needed. E.g.
> > move the laptop off the soft surface that is blocking the air vents.
> 
> I don't think having a critical severity message is nearly enough.
> There are cases where the users simply won't see that message, no shell
> opened, nothing scanning dmesg, nothing pops up on the desktop to show
> KERN_CRIT messages, etc.
> 
> If we really wanna handle this case then we must be much more reliable:
> 
> * we throttle the machine from within the kernel - whatever that may mean
> * if that doesn't help, we stop scheduling !root tasks
> * if that doesn't help, we halt
> * ...

We have forced idle injection, that should be able to reduce the system
to barely functional but non-cooker status.
