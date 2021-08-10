Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B523E7B9B
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbhHJPCn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 11:02:43 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:57676 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234153AbhHJPCn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 11:02:43 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 42AD51836942D;
        Tue, 10 Aug 2021 15:02:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id A6904D1516;
        Tue, 10 Aug 2021 15:02:18 +0000 (UTC)
Message-ID: <b3070c0352e2a5661a1a59d5c5354cc82a1cce1e.camel@perches.com>
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Aug 2021 08:02:17 -0700
In-Reply-To: <YRKO4An9UkObVGmB@rric.localdomain>
References: <20210807155957.10069-1-len.baker@gmx.com>
         <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
         <20210808112617.GA1927@titan> <YRD90L6PMoVbbv+9@rric.localdomain>
         <99448ef29830fda9b19409bc23b0e7513b22f7b7.camel@perches.com>
         <YRKO4An9UkObVGmB@rric.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A6904D1516
X-Stat-Signature: zomo8gkouz7irgaf7tbabch1cxordum7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Gpl2phGQ76xLkFse458J6cytt06otvuo=
X-HE-Tag: 1628607738-261957
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2021-08-10 at 16:36 +0200, Robert Richter wrote:
> On 09.08.21 10:18:58, Joe Perches wrote:
> 
> > strscpy and scnprintf have different return values and it's simpler
> > and much more common to use scnprintf for appended strings that are
> > limited to a specific buffer length.
> 
> Calculating the bytes written from the return value is a oneliner.

Not really.
You still have to test for strscpy's possible return of -E2BIG.



