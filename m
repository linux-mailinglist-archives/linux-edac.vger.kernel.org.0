Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA0449C819
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiAZKyU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 05:54:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40272 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233548AbiAZKyT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Jan 2022 05:54:19 -0500
Received: from [127.0.0.1] (dynamic-002-247-255-194.2.247.pool.telefonica.de [2.247.255.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3DCB51EC053F;
        Wed, 26 Jan 2022 11:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643194454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6VxIGPCiAX/Ux43qsziYait7zWpnkX5fyLlXBWmjoA=;
        b=XCHrTpd/y/ybsaPtq1xAPD39O9fAr+u3laqH17lE0ZEfwC+6JfVuMUmtQaQwUcc/mbpbbT
        BZqR4GairU7LjzSH2hVbf+QzqVnopLEoyjRCSCUVQ/MhBL4jj5ji8q1U32dj74pzBrVEfK
        1rkLLzwKJMr8O6GMmB+VVxEaBBF2uQA=
Date:   Wed, 26 Jan 2022 10:54:11 +0000
From:   Boris Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        tony.luck@intel.com
Subject: Re: [PATCH v2] RAS: Report ARM processor information to userspace
User-Agent: K-9 Mail for Android
In-Reply-To: <20220126030906.56765-1-lostway@zju.edu.cn>
References: <20220126030906.56765-1-lostway@zju.edu.cn>
Message-ID: <BB2F2992-E9FB-435D-B33C-2334E3D9F3D3@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On January 26, 2022 3:09:06 AM UTC, lostway@zju=2Eedu=2Ecn wrote:
>From: Shengwei Luo <luoshengwei@huawei=2Ecom>
>
>The ARM processor error section includes several ARM processor error
>information, several ARM processor context information and several
>vendor specific error information structures=2E In addition to these
>info, there are error severity and cpu logical index about the event=2E
>Report all of these information to userspace via perf i/f=2E

 A patch commit message needs to explain why a change is being done, not w=
hat is being done=2E The "what" I can see most of the time=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
