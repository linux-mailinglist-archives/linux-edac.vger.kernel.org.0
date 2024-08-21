Return-Path: <linux-edac+bounces-1709-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25E9596D4
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753C5B20FE1
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230816729D;
	Wed, 21 Aug 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gptEek3j"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF915749E;
	Wed, 21 Aug 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228317; cv=none; b=ZrvemXieOeOXWgoCY05V1wjDFkwyQpS7F9dsPt6eKCaFn3miAERkZTyGZTL5dZYAfLjs4JhNaLhsSDIvLZmHV3A5cDDoakLMqiLu8dPnStXEnNlki714cXVpYNRnQ2LVp4seA8qK3qifHt4iDh+fuHCMtIAJRadqdwIA17NUacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228317; c=relaxed/simple;
	bh=5uA8T7eQ+lNu5qeazxEqhCxUSRdkNMbJ2GOmo18fIjo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ClunPdfHWyNgFjlDzQpNUirTg+4NTqlfXinvQvVOPsUIhlW925d6PEWR1aXFsAxDPxpzS/HM2pI7eobJtOzbE3tFEKHdxh228Mr/oi6b2zeMl3ypjKVZEPLU3owtheT2nhKAtMGsNbZ3yAdoDOVW58gsEdH3kO7zg5LKdKY3pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gptEek3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1C0C32782;
	Wed, 21 Aug 2024 08:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724228317;
	bh=5uA8T7eQ+lNu5qeazxEqhCxUSRdkNMbJ2GOmo18fIjo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gptEek3j16P6KPKz4wnZDKrNvFmWHTV4RuoqBJhmYsUfKAXMmgQCuPuLV/nrmKrcY
	 /zIuDIR2PdwGd9SoAuseRkJhItaT3ra2pEL0Q7MYLK2kodQv8djQn8R97Ciqp87z3M
	 BbuhjWgx8dpqakpFZevAJf/fghdR6sETU8d8tQ1tRds26ntdAMc1K1IQcLLUrDjlnV
	 CX8YOhr88WtNO7/xoZwELHLqoQRC7GJRd1XqSNNhr3vHBixO5R739MM13R4+FzWo88
	 ZQCZ4WoEeKWvTNBp5IkmD2am4xbzKyv6SDEqzkrS7dvBAU5uBuTW2/r4N6pxtaWXd7
	 jlSVBs2KOJxMg==
Date: Wed, 21 Aug 2024 03:18:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: kernel@xen0n.name, krzk+dt@kernel.org, chenhuacai@kernel.org, 
 linux-edac@vger.kernel.org, bp@alien8.de, conor+dt@kernel.org, 
 rric@kernel.org, loongarch@lists.linux.dev, james.morse@arm.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 tony.luck@intel.com, mchehab@kernel.org
In-Reply-To: <20240821064728.8642-3-zhaoqunqin@loongson.cn>
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
 <20240821064728.8642-3-zhaoqunqin@loongson.cn>
Message-Id: <172422831551.3074054.5974541673694323697.robh@kernel.org>
Subject: Re: [PATCH v1 2/2] dt-bindings: EDAC for loongson memory
 controller


On Wed, 21 Aug 2024 14:47:28 +0800, Zhao Qunqin wrote:
> From: zhaoqunqin <zhaoqunqin@loongson.cn>
> 
> Add: drivers/edac/loongson_edac.c
> 
> Signed-off-by: zhaoqunqin <zhaoqunqin@loongson.cn>
> ---
>  .../bindings/edac/loongson,ls-mc-edac.yaml    | 35 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.example.dtb: mc0@1fe00600: reg: [[0, 534775296], [0, 80]] is too long
	from schema $id: http://devicetree.org/schemas/edac/loongson,ls-mc-edac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240821064728.8642-3-zhaoqunqin@loongson.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


