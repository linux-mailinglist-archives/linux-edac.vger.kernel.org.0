Return-Path: <linux-edac+bounces-1352-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4591469F
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 11:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598861F2440E
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD513699A;
	Mon, 24 Jun 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVvXwvTa"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7F5380F
	for <linux-edac@vger.kernel.org>; Mon, 24 Jun 2024 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222346; cv=none; b=c5cA/MF5hzzZfjsRPTdnwpihiqpWP8cXoODo23csCMPFL74QyK3rZRcsxMJvg7GJ21G05KGJDK2Dd44NOtdRU83ij9uAPRjllVt6A+qOlMLZSMQ3kPIThXHmFLV0wOk67Qj7C8j0arhEoN+gBzC/4VcVTrj47ZEMJ/c9g96l2QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222346; c=relaxed/simple;
	bh=cW52zxJgpVsSrE9cLev7A24Pl9+DDNAp4ic425Ti+Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tD/NDk2csL5P4L46QdJaSOmAmbTBvLIkXjQvqsCYLcUdufkhORbsihSEvr/GPCTaA5g3vHJESWp/AKIhNQ9MgUigQfwS3e25RgIBGSLR8sl7aE/pAGU7ySbRurWrmK4phFFbfSyX/JiR6Mkyxy7l7QGrxUchNRs+uTKm09vqXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVvXwvTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0246FC2BBFC;
	Mon, 24 Jun 2024 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719222345;
	bh=cW52zxJgpVsSrE9cLev7A24Pl9+DDNAp4ic425Ti+Y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EVvXwvTa2dRso95ijmvxkEJ8uAhkbmG37zOi+grH8prpdua6kADnowYph3H4mI6+g
	 JkKtGCwrutt4IJnNqvNDIYX0YHJHV35/afDZZh8vCfWmvWXGQDZMl+CzNDS5a3iPre
	 AXbfEpO30WPRVmcVvicq0wk4IefC+thYSegFbpRXdRH9q79whpXhO5DXxwUXpCHB22
	 ZqpJV3IWeID8vFwEnEH3kNvSsKFsXw8Aq8dXhi5ir0EnZKXit3Am/8upEBGDnWLWzL
	 2R6Bo6feNlIHLKqIXVIkiiJfqJRKA23Dvp6KLxxdLlnBicDmP7JGDfUt/qQ7HvN68I
	 sa8162M5uux4w==
Date: Mon, 24 Jun 2024 11:45:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <shiju.jose@huawei.com>, <qemu-devel@nongnu.org>,
 <linux-edac@vger.kernel.org>, <tanxiaofei@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Message-ID: <20240624114540.400b70a1@coco.lan>
In-Reply-To: <20240621193316.00000d83@Huawei.com>
References: <20240621165115.336-1-shiju.jose@huawei.com>
	<20240621193316.00000d83@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 21 Jun 2024 19:33:16 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Fri, 21 Jun 2024 17:51:15 +0100
> <shiju.jose@huawei.com> wrote:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>  
> Thanks for posting this.
> 
> Given this is going to linux-edac, probably should mention
> this is QEMU based error injection.  For cross postings
> between kernel related and qemu lists I tend to stick
> qemu in the [] of the patch description.

Thank you for that! It is really useful. Btw, I'm using a small
script to do the error injection using netcat (nc), and assuming
that the QMP interface used for error injection will be started 
at localhost port 4445, e. g. qemu is started with:

	-qmp tcp:localhost:4445,server=on,wait=off

Btw, I added some instructions about how to use it under rasdaemon
page:

	https://github.com/mchehab/rasdaemon/wiki/Error-injection-testing

Feel free to improve it.

Thanks,
Mauro

---


#!/bin/bash

trap 'catch $LINENO "$BASH_COMMAND"' ERR
catch() {
	echo "Error on line $1: $2"
	exit 1
}

ERROR_DEFAULT='"cache-error"'
ERROR=""

HELP="$0 [<-c|--cache-error> <-t|--tlb-error> <-b|--bus-error> <-v|--vendor-error>|--micro-arch-error]"

while [ "$1" != "" ]; do
	case "$1" in
		-c|--cache-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"cache-error"'
			;;
		-t|--tlb-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"tlb-error"'
			;;
		-b|--bus-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"bus-error"'
			;;
		-v|--vendor-error|--micro-arch-error)
			if [ ! -z "$ERROR" ]; then ERROR="$ERROR, "; fi
			ERROR+='"micro-arch-error"'
			;;
		help|-h|--help)
			echo $HELP
			exit 0
			;;
	esac
	shift
done


if [ -z "$ERROR" ]; then
	ERROR=$ERROR_DEFAULT
fi

CACHE_MSG='{ "execute": "qmp_capabilities" } '
CACHE_MSG+='{ "execute": "arm-inject-error", "arguments": { "errortypes": ['$ERROR'] } }'

echo $CACHE_MSG
echo $CACHE_MSG | nc -v localhost 4445



