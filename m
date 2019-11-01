Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB9EC5E9
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2019 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfKAPyY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Nov 2019 11:54:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52652 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfKAPyY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 1 Nov 2019 11:54:24 -0400
Received: from nazgul.tnic (unknown [46.218.74.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25F2B1EC0AD6;
        Fri,  1 Nov 2019 16:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572623663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vU6VGS46rfg0BH1qVh/1bYvbh3G5urqXBMKadSJ/iro=;
        b=CEtN9CI/TgQxUo/VD7Kqn6nOrA9q5B2ao4s5aCW7j8Qmsw2QNYdFSTuignxxD4ju5GyXO1
        hARQDoV7vZMX0kTTW7dteByHvEglKiVCfP9rVcQrrcC+jOoW+j7ltgLDCr/6hbGrW0bwaB
        f2yNmiSyVSHHwMhuqmWXAJiDj4yt18Y=
Date:   Fri, 1 Nov 2019 16:54:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191101155412.GA2300@nazgul.tnic>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
 <20191025133456.GA6483@zn.tnic>
 <BYAPR12MB2630ED1425A3F01727E1C45BF8620@BYAPR12MB2630.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR12MB2630ED1425A3F01727E1C45BF8620@BYAPR12MB2630.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Nov 01, 2019 at 03:19:36PM +0000, Ghannam, Yazen wrote:
> Is the module being probed twice? We have this problem in general, e.g. the
> module gets loaded multiple times on failure.

Yap, it looks like it.

> The clue for me is that node 0 gets detected twice. This is done in
> per_family_init() early in probe_one_instance().
>
> In any case, I think we can make !ecc_enabled(pvt) in probe_one_instance() a
> failure now that we have an explicit check for memory on a node. In other
> words, if we have memory and ECC is disabled then this is a failure for the
> module.

Yeah, for that case we should be printing ecc_msg. Makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
