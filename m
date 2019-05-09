Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7484218C5A
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfEIOwJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 10:52:09 -0400
Received: from ozlabs.org ([203.11.71.1]:41961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEIOwJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 10:52:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450GX673Z2z9s4V;
        Fri, 10 May 2019 00:52:06 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>,
        Johannes Thumshirn <morbidrsa@gmail.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
In-Reply-To: <20190508101238.GB19015@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au> <20190506065045.GA3901@x250> <20190508101238.GB19015@zn.tnic>
Date:   Fri, 10 May 2019 00:52:05 +1000
Message-ID: <87o94bvfxm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Mon, May 06, 2019 at 08:50:45AM +0200, Johannes Thumshirn wrote:
>> Acked-by: Johannes Thumshirn <jth@kernel.org>
>
> Queued, thanks.

Thanks. It would be nice if you could send it as a fix for 5.2, it's the
last thing blocking one of my allmodconfig builds. But if you don't
think it qualifies as a fix that's fine too, it can wait.

cheers
