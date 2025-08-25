Return-Path: <linux-edac+bounces-4650-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C724BB33E10
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0301718E4
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE942E92C4;
	Mon, 25 Aug 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jDGkvf71"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525472EA46D;
	Mon, 25 Aug 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121452; cv=none; b=AhMJGvjXa+w8r5gTMdq75QzeU5qxJ3Hlszr72LJ6NP9R9fHtJg3KFpfjosSh58+YivSXhigYSapjGyBoOaTv4zuUsXNQZaowCqbB+eCeus/XWzrSG1Fs6zxat53ebiIM51sd+2ULlktxPS2j/rQO48Y2QCZJ19mGc/SUBbqngP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121452; c=relaxed/simple;
	bh=SQ9HcxU5Qybi1UGN7UeAP5UxQ1xe7QVkbUybnjoJue0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=r5QGBvc2BIdZfr0vkpIdt2rhum6AtPX2WbBw992WFrFMtdLN+3YUp2IwUMQXcXpE4DUuhacBTzNOo/bXQO0MUURIkuM6NKqsbU2E2TFyxNJLpcxppvH1O3oa0xVVZXGyW6tS253x2Dx9XZao8pzfFeQR4pLIPflv0R6uU3BjDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jDGkvf71; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756121444; x=1756726244; i=markus.elfring@web.de;
	bh=SQ9HcxU5Qybi1UGN7UeAP5UxQ1xe7QVkbUybnjoJue0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jDGkvf71khmIuH8/6u3OaMwzR+vx3VVMOWcVv2OtVvSgmzm2U0LqM81dKXqfobyH
	 zjWJ79BFci0qESBIGjX7rOrZxFxPLMxTVNgvOupEdh1mtFSO0pNp6rUCzSZQ0TmWL
	 xXbD6M27O5KeeQ3Dc2E/QnZ2gIx7/cZ94zKS62GmEuUJmKMjehvkCgx/rvTOqF7/T
	 ihbZltf2X9ip5LMC81seC1zH0W/JXjgb08y82GfPi8SiZ2o4wCGr/Q+Lup5oCMDq8
	 qNyV/1lt2O5aRWfhdM2qA+FcAiYnwp/jlrdOFRCZcWCpe8j3XeW45U5lPE7nDPcWC
	 CCiNR/qLkNtMEcQI6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKXb-1uZFXZ2Tkv-00rfZK; Mon, 25
 Aug 2025 13:30:44 +0200
Message-ID: <1b3b072e-8db3-4858-8b31-c312ca9c0c9d@web.de>
Date: Mon, 25 Aug 2025 13:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC: altera: Delete an inappropriate dma_free_coherent()
 call in altr_sdr_mc_err_inject_write()
To: Salah Triki <salah.triki@gmail.com>, linux-edac@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Dinh Nguyen <dinguyen@kernel.org>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 Tony Luck <tony.luck@intel.com>
References: <aIrfzzqh4IzYtDVC@pc>
Content-Language: en-GB, de-DE
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aIrfzzqh4IzYtDVC@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W3uZqjoxBhqO+iOcTnETPc8u7KHUE6o53mIMthevhsQ4tb0PCzp
 sMwSVsz4pwz/yoHc0Cqii1SgGclfSZOh/uUZnfeePKrk04uYgZ0ZFKw0srNSst8A6LYmF06
 1NDP6iOMyjO0S8q7rwYkMv4DREJ9zxxAbPal5QOwbOtOxnqtYSjxHH9nWEKbY26uWbhLsK1
 EH5B4UGmu0oY84aMAN6ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bbaQvMFwBjY=;gqt2oQvv+ScMHK72c6LCzV+3QA4
 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
 iidOJA8=

=E2=80=A6> Add a check to ensure that the memory is only freed when the al=
location
> was successful.

How good does such a wording fit to the proposed function call deletion?

Regards,
Markus

