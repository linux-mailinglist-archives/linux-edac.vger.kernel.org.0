Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB930804
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2019 07:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaFOF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 01:14:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37894 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaFOE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 01:14:04 -0400
Received: from cz.tnic (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B6E21EC0747;
        Fri, 31 May 2019 07:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559279642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dPY3XGBqhKD5FKYXjl8Me7lXXlj1TGKKetXF9jozRKo=;
        b=nJ4npLw9pBK+/yUTCph5KX5VxsyPjGz/Zrd8R/cHcPQyDE3pOteQHB56wjexF4jR1BhyyI
        YzojWZzi8QAxVZkMF4tKCDhsCUfwX95DkdWHSqPjV5fbdl6PDtH2UJSLbjxhHp5NWvbQ/3
        ZSu1bk+pIt9MYFf9peXJzdkbzRaRIPU=
Date:   Fri, 31 May 2019 07:14:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "james.morse@arm.com" <james.morse@arm.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Message-ID: <20190531051400.GA2275@cz.tnic>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 31, 2019 at 01:15:33AM +0000, Herrenschmidt, Benjamin wrote:
> This isn't terribly helpful, there's nothing telling anybody which of
> those files corresponds to an ARM SoC :-)

drivers/edac/altera_edac.c is one example.

Also, James and I have a small writeup on how an arm driver should look
like, we just need to polish it up and post it.

James?

> That said ...
> 
> You really want a single EDAC driver that contains all the stuff for
> the caches, the memory controller, etc... ?

Yap.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
