Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE257305D3
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2019 02:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEaAfI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 20:35:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfEaAfI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 May 2019 20:35:08 -0400
Received: from cz.tnic (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F3A71EC048A;
        Fri, 31 May 2019 02:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559262907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dL4Q7H1RzI/U415F83326iuQleoLP8cRBYlKonLtIAA=;
        b=XMVG4VkDB3/wPVzUlw18YET6qYZJx1qL7wb7B9xmCuZqODESTDttUmRrIH/d6wqmDcoZwD
        4PKainp6OgnS3JI6oGKb37uQ6yxMjywCWIR3j6VX98LKjqYKXhsnj0lQ8zdWSibF4Xp7pm
        bsJXh/MiQWb768XcdGEL1HsBuUv3so0=
Date:   Fri, 31 May 2019 02:35:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hanna Hawa <hhhawa@amazon.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, james.morse@arm.com,
        davem@davemloft.net, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: EDAC: add Amazon Annapurna Labs EDAC
 binding
Message-ID: <20190531003504.GA2630@cz.tnic>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-2-git-send-email-hhhawa@amazon.com>
 <20190530115446.GA14088@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190530115446.GA14088@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 30, 2019 at 04:54:46AM -0700, Greg KH wrote:
> I know I can't take patches without any changelog text,

I thought I was the only one?! :-)

Good.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
