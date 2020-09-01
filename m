Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDD258847
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgIAGeI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 02:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAGeH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Sep 2020 02:34:07 -0400
Received: from coco.lan (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074A02087D;
        Tue,  1 Sep 2020 06:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598942047;
        bh=Ad3Sw2BiWmseZCUV4/cWl6c+iXr6HgfOMEYjR5gqfQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L+CV54ko51AWprklx8zS7MvGxka2is2oKme0PyeS4ioAipxt31xiVjk9SegOJxzeW
         GWhmcWfl1cnRRIvrZj1JiiABqgDjRBfpJzZpIe8X5NGeqDC9+NzhkUcQ8F5WsQTuna
         7z0IIpx1byTOY4ErSsVufu7Ai3glv3niQ7exa/BE=
Date:   Tue, 1 Sep 2020 08:34:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 1/1] rasdaemon: Modify non-standard error decoding
 interface using linked list
Message-ID: <20200901083403.7c199bd7@coco.lan>
In-Reply-To: <20200810144256.1311-1-shiju.jose@huawei.com>
References: <20200810144256.1311-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Mon, 10 Aug 2020 15:42:56 +0100
Shiju Jose <shiju.jose@huawei.com> escreveu:

> Replace the current non-standard error decoding interface with the
> interface based on the linked list to avoid using realloc and
> to improve the interface.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Patch merged, thanks!

Thanks,
Mauro
