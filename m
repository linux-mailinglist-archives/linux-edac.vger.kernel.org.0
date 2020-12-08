Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F952D26D0
	for <lists+linux-edac@lfdr.de>; Tue,  8 Dec 2020 10:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgLHJDR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Dec 2020 04:03:17 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbgLHJDQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Dec 2020 04:03:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CqvMZ0yzzz9sWQ;
        Tue,  8 Dec 2020 20:02:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1607418154;
        bh=1JsjWFPNaV7qbLNXrHlyg89qbEGvqxuYkxQMK5KbnFQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pXld9tk0Xub1pSabCDtKvca714+NbQwOXMwQwQEQjZvKG501Wx/3eEWcqIXCwXKa5
         3JfDe14HYXGruM22k+uuC7cVDxAhQEptFDtatXqCm2eTB0YhvkvLPQ9lQ951Rz+2GU
         9QXjyAenMl7KYCJJXU2PjLfoknRM0BSOSK5EMCe5uwjUZ33dmaFmAVB9EtJBXrFh1U
         rvwCRBWhcqALRvef4SyjYiPajb2V/Br2pxdLyb1XW+02DA45AngtfucrsCoSRyAw/X
         8lxQaj2Zvagm5DMUd088l1jfGIkuM7+6T0PIeifxbco4CyT7LOGcZZilBk9TRlmfnY
         OOgbegDG0C0LQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC/mv64x60: Remove orphan mv64x60 driver
In-Reply-To: <20201207111727.GC20489@zn.tnic>
References: <20201207040253.628528-1-mpe@ellerman.id.au> <20201207111727.GC20489@zn.tnic>
Date:   Tue, 08 Dec 2020 20:02:31 +1100
Message-ID: <874kkwu0uw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Mon, Dec 07, 2020 at 03:02:53PM +1100, Michael Ellerman wrote:
>> The mv64x60 EDAC driver depends on CONFIG_MV64X60. But that symbol is
>> not user-selectable, and the last code that selected it was removed
>> with the C2K board support in 2018, see:
>> 
>>   92c8c16f3457 ("powerpc/embedded6xx: Remove C2K board support")
>> 
>> That means the driver is now dead code, so remove it.
>> 
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/edac/Kconfig        |   7 -
>>  drivers/edac/Makefile       |   1 -
>>  drivers/edac/mv64x60_edac.c | 883 ------------------------------------
>>  drivers/edac/mv64x60_edac.h | 114 -----
>>  4 files changed, 1005 deletions(-)
>>  delete mode 100644 drivers/edac/mv64x60_edac.c
>>  delete mode 100644 drivers/edac/mv64x60_edac.h
>
> Gladly taken and applied, thanks!

Thanks.

cheers
