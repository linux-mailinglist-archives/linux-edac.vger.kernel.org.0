Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671A925883D
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIAGbT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 02:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgIAGbT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Sep 2020 02:31:19 -0400
Received: from coco.lan (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9B12087D;
        Tue,  1 Sep 2020 06:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598941878;
        bh=A8gt0muO54X2dVmJeYL8q5p5CzTw2anvFMnLShIYyz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RVZ3BIBcVxAmiI5d5O6+zQyzyOEJJIyLb8qXgQne8gVDKFhoAp+k7ctoUcIYDcHaU
         hKYIEeSZ0qk7zTIxInW6GJv90x4AwcSYeceh+xwGsHoA6yJNYM4YAu1cKfgzVj46z8
         4qLGyAg3SRv7coo7lsmGqZm+UGQMxpvXDrQb/ukk=
Date:   Tue, 1 Sep 2020 08:31:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH rasdaemon 0/3] add support for hisilicon common section
 decoder
Message-ID: <20200901083115.7345082c@coco.lan>
In-Reply-To: <1595835519-32039-1-git-send-email-tanxiaofei@huawei.com>
References: <1595835519-32039-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Mon, 27 Jul 2020 15:38:36 +0800
Xiaofei Tan <tanxiaofei@huawei.com> escreveu:

> 1.Delete some duplicate/useless code.
> 2.Add support of hisilicon common section decoder for Kunpeng series.
> 
> Xiaofei Tan (3):
>   rasdaemon: delete the duplicate code about the definition of hip08 DB
>     fields
>   rasdaemon: delete the code of non-standard error decoder for hip07
>   rasdaemon: add support for hisilicon common section decoder

Patches merged, thanks!

Thanks,
Mauro
