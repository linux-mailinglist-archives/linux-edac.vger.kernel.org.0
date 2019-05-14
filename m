Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C81C368
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2019 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfENGux (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 May 2019 02:50:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfENGuw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 May 2019 02:50:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4537cT66Rkz9s3Z;
        Tue, 14 May 2019 16:50:49 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
In-Reply-To: <20190510182512.GG29927@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au> <20190506065045.GA3901@x250> <20190508101238.GB19015@zn.tnic> <87o94bvfxm.fsf@concordia.ellerman.id.au> <20190509145534.GD17053@zn.tnic> <20190509180220.GH17053@zn.tnic> <87bm0avb03.fsf@concordia.ellerman.id.au> <20190510141320.GB29927@zn.tnic> <20190510182512.GG29927@zn.tnic>
Date:   Tue, 14 May 2019 16:50:49 +1000
Message-ID: <87d0klttpy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Fri, May 10, 2019 at 04:13:20PM +0200, Borislav Petkov wrote:
>> On Fri, May 10, 2019 at 08:50:52PM +1000, Michael Ellerman wrote:
>> > Yeah that looks better to me. I didn't think about the case where EDAC
>> > core is modular.
>> > 
>> > Do you want me to send a new patch?
>> 
>> Nah, I'll fix it up.
>
> I've pushed it here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=edac-fix-for-5.2
>
> in case you wanna throw your build tests on it. My dingy cross-compiler
> can't do much really.

Looks good. I even booted it :)

cheers
