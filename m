Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A54E992A
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbiC1OSM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiC1OSE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 10:18:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834C23176;
        Mon, 28 Mar 2022 07:16:23 -0700 (PDT)
Received: from zn.tnic (p200300ea9715611f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:611f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D4FD1EC04CB;
        Mon, 28 Mar 2022 16:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648476978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yyk7oPNO8DXywdIUh6zaEHR6HcyilaTOQGe6/MxL3sQ=;
        b=RpiKAiKQ5UbifdBAopk2vGdhezpWw7vN/EPgKyquwQuVYPWf/Ze0nHb2fQTJwWgz+4CNPA
        kWaFmfGRPTqNxwjzr6KonA6GQSgIkWFRowiaDuNhMb84bsZDOxz/LocVnRf8nMpwdGCT+K
        HnqBpL97PLFR0A3U5R2nrGXGzyO3jdc=
Date:   Mon, 28 Mar 2022 16:16:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH 0/2] x86/mce: Grade new machine errors for AMD MCEs and
 include messages for panic cases
Message-ID: <YkHDMP7QqUK5dGEr@zn.tnic>
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
 <YkG+SFCYMoAXrqJ3@zn.tnic>
 <299368f0-a3f3-c252-ab98-7dd324dbd3c5@amd.com>
 <YkHAcIZDpZER9knA@zn.tnic>
 <af1a189f-4eeb-8bc2-fe60-ff317a3963f6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af1a189f-4eeb-8bc2-fe60-ff317a3963f6@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 28, 2022 at 09:09:04AM -0500, Carlos Bilbao wrote:
> Thanks Borislav -would you like me to resend this once -rc1 opens?

No need - I have it already. Btw, those documents also explain when
to resend: when the patches need to be changed or when they've been
forgotten. Most people usually send a "ping email" as a reply to the
thread to remind the maintainer to handle them, in that latter case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
