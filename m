Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D856D8A9F
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbfJPIOO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 04:14:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfJPIOO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Oct 2019 04:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=muEAjSBNXIfkLN3HPiA3QlifKtY10OMjDOU7+2ucKH8=; b=gyFxNMYFYwJPyO/2uMQ6dizoB
        S28YnsW1It2VmkLf44hVQLxRI5ObiW8L2hn8JInaLX2CvR8nn3iPCtVFSvego3/PmilrqCe/RsCvL
        jkY3c8SeoosMUNTGOuU8PvEMEhgVtNGaOfJiTBbTnuBG8/vpgrjxaeXO80G+FuPaTDdwRSICY3bw3
        9HEnfMAKlRPD1ch7EYTntBBAsNRMU431NMCdzTaNxii5uQnqcBxj2D9nMLw1+CRl43xLdzAC/ZpZn
        I2NZmdLpWkOCXuYaqbmcYGawIs49on0amO7efAKINbII6pBJ4jWGVbXrq8h4JYXW9ym25Wi7EwUT1
        MvOktnzFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKeRb-0003dT-3K; Wed, 16 Oct 2019 08:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 368F53032F8;
        Wed, 16 Oct 2019 10:13:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C50C20B972E4; Wed, 16 Oct 2019 10:14:05 +0200 (CEST)
Date:   Wed, 16 Oct 2019 10:14:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191016081405.GO2328@hirez.programming.kicks-ass.net>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 15, 2019 at 06:31:46AM -0700, Srinivas Pandruvada wrote:
> On Tue, 2019-10-15 at 10:48 +0200, Peter Zijlstra wrote:
> > On Mon, Oct 14, 2019 at 02:21:00PM -0700, Srinivas Pandruvada wrote:
> > > Some modern systems have very tight thermal tolerances. Because of
> > > this
> > > they may cross thermal thresholds when running normal workloads
> > > (even
> > > during boot). The CPU hardware will react by limiting
> > > power/frequency
> > > and using duty cycles to bring the temperature back into normal
> > > range.
> > > 
> > > Thus users may see a "critical" message about the "temperature
> > > above
> > > threshold" which is soon followed by "temperature/speed normal".
> > > These
> > > messages are rate limited, but still may repeat every few minutes.
> > > 
> > > The solution here is to set a timeout when the temperature first
> > > exceeds
> > > the threshold.
> > 
> > Why can we even reach critical thresholds when the fans are working?
> > I
> > always thought it was BAD to ever reach the critical temps and have
> > the
> > hardware throttle.
> CPU temperature doesn't have to hit max(TjMax) to get these warnings.
> OEMs has an ability to program a threshold where a thermal interrupt
> can be generated. In some systems the offset is 20C+ (Read only value).
> 
> In recent systems, there is another offset on top of it which can be
> programmed by OS, once some agent can adjust power limits dynamically.
> By default this is set to low by the firmware, which I guess the prime
> motivation of Benjamin to submit the patch.

That all sounds like the printk should be downgraded too, it is not a
KERN_CRIT warning. It is more a notification that we're getting warm.
