Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E271E2FB3E
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 13:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE3Lyr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 07:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfE3Lyr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 May 2019 07:54:47 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF5925887;
        Thu, 30 May 2019 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559217286;
        bh=DhoJi0ieSjYPAqo8vLH3MyC5Ank0z//9mLxB6RE6mCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsnjKu6DScHMoKvfoxY6CebtoYLQJlmSs2A58xSCc4ytw14eJDtGTruZc0zVkUJ8f
         SyB/f0qM+CnXDy9OlVMmh4qqRVCR4yfzYn9rVdQGVQGgSd+nacATgpcoVUKtm2+oWW
         tkCnF+H8c3PJkDXyu26BAoWxkl3aYL03K1tgxb8Q=
Date:   Thu, 30 May 2019 04:54:46 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: EDAC: add Amazon Annapurna Labs EDAC
 binding
Message-ID: <20190530115446.GA14088@kroah.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-2-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559211329-13098-2-git-send-email-hhhawa@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 30, 2019 at 01:15:28PM +0300, Hanna Hawa wrote:
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  .../devicetree/bindings/edac/amazon-al-edac.txt          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon-al-edac.txt

I know I can't take patches without any changelog text, but perhaps
other maintainers are more leniant... :)

Please fix up.

thanks,

greg k-h
