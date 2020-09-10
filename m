Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAB26495F
	for <lists+linux-edac@lfdr.de>; Thu, 10 Sep 2020 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIJQLW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Sep 2020 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgIJQLH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Sep 2020 12:11:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C45C061757;
        Thu, 10 Sep 2020 09:11:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f133200a473c2fd688a37dc.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:3200:a473:c2fd:688a:37dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E13F61EC04DE;
        Thu, 10 Sep 2020 18:11:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599754261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sV2huq5fOJK6jTiNRjfJV1JPJGk72Qa1SyQ3JsvCdV4=;
        b=LnKwRkjXLltK66th/Y6sraQDHnsj/3bdrKKkolThWwOwYXkIrnA0sOi48FIx/syFgh3Goh
        utL/j1zZ7uLIevrUTzlX/JJg4TBKl3eFjuVUdirIpQsZb9sV85ToG/kMjEm/7BRBS6di4e
        8U+TuYgKUnTJ/bqDQewyo7ijdUfDa9w=
Date:   Thu, 10 Sep 2020 18:11:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] EDAC: sb_edac: simplify switch statement
Message-ID: <20200910161100.GI8357@zn.tnic>
References: <20200907153225.7294-1-trix@redhat.com>
 <7525690b6aaa4e539989b9c2e5703a56@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7525690b6aaa4e539989b9c2e5703a56@intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 08, 2020 at 10:08:28PM +0000, Luck, Tony wrote:
> [Boris: Pushed to edac-misc and edac-for-next branches in RAS tree]

Yap, looks good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
