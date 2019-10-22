Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0AE03E5
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbfJVMd3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 08:33:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388095AbfJVMd3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 08:33:29 -0400
Received: from zn.tnic (p200300EC2F0D77000D5BF9E7EE486C9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7700:d5b:f9e7:ee48:6c9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6CD11EC0C83;
        Tue, 22 Oct 2019 14:33:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571747608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TOK7ihLmgboiz3S90Wstv50WNK+dthXs+4GiX5bvbg8=;
        b=Rg8YnUWiDfyx9XFAaV3nUX1jtnMyr6trZuSkaxUaDGdrWDKuQsymtSPvwceAn9woRzzfGd
        k/AuGe49YQxbt7hAHDZMsltsn0Vr0fkExPZT6dP1+9l24acOZum/iLN6wxAvFLG76UAytc
        NVarrKcoDbiFzxx7o1dZuN4x50tl21w=
Date:   Tue, 22 Oct 2019 14:33:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     James Morse <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <20191022123318.GD31700@zn.tnic>
References: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
 <20190923161015.GI15355@zn.tnic>
 <e2b9cd68-abaa-bdcd-cc56-cca285272569@outlook.com>
 <41637032-a308-9a92-1b49-cb51af2580f8@outlook.com>
 <BY5PR04MB65996A0CEB37001C763B248C866C0@BY5PR04MB6599.namprd04.prod.outlook.com>
 <1ae9a840-d5b6-ccd6-8481-d43665b4411b@arm.com>
 <BY5PR04MB659953E22E846D0BF4384D0086690@BY5PR04MB6599.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR04MB659953E22E846D0BF4384D0086690@BY5PR04MB6599.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 21, 2019 at 05:36:09PM +0000, Lei Wang wrote:
> Is there some guideline on what email addresses are liked and not
> liked? Thanks!

We have a document which talks about mail clients and not so much about
mail servers:

https://www.kernel.org/doc/html/latest/process/email-clients.html

but in general, use a linux system to create and send your patches and
avoid Exchange for patches because it is notorious for mangling them.

Most kernel people I know use emacs or mutt with an imap account through
which they shuffle mail with fetchmail etc.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
