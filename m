Return-Path: <linux-edac+bounces-1538-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AC933FC2
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 17:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087A81F242CC
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFFC181CE5;
	Wed, 17 Jul 2024 15:34:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A9181BB3;
	Wed, 17 Jul 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230495; cv=none; b=fIMXKubVH9LFJ+GykK2OWyTiJjo0CwhlbObpGI2a9CE9kan2kq6GrDSRLgSgh/sTP77+5lvzL6Mz4qktZ8nm0lZ4+seOXnDgWRxYfH4VFhi1LZx/LtqSc9KR1Ro41rYyJO1pMp4ipga1hOFW1/6B/1Ex1Oc96Gu4UJEwzHaNJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230495; c=relaxed/simple;
	bh=//A4za5JG/cce/YFg7vvCVRF/dpaPs0AXrJYD0Q+dHs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkgUGaaUKB29+dVgUdoCkefxjPMIR8OAyDUx1Inlt97ChQ7Vtzh7pRshxMn7IFK2PRBPXVymK6UOH4zxUO2thmdcyROmZD7sfmpUOgONyGdPKmkr3KnFDiD/SGAMKiYA9DE4bbDaZSlZP917uJaCqoJgH04yhmma5A4I+EAjhbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPKhh38XYz6D8Yd;
	Wed, 17 Jul 2024 23:33:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F0E2140A70;
	Wed, 17 Jul 2024 23:34:43 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 16:34:43 +0100
Date: Wed, 17 Jul 2024 16:34:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, "Shannon Zhao"
	<shannon.zhaosl@gmail.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/7] arm/virt: place power button pin number on a
 define
Message-ID: <20240717163442.00002b78@Huawei.com>
In-Reply-To: <88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
References: <cover.1720789921.git.mchehab+huawei@kernel.org>
	<88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Jul 2024 15:15:08 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Seems sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

